execute "execute_cassandra" do
		command <<-EOH
		cd #{node['work_dir']}/#{node['cassandra']['base_name']}-#{node['cassandra']['version']}
		sudo bin/cassandra
	EOH
	not_if "pgrep -fl cassandra"
	# action :nothing
end

execute "extract_cassandra" do
	command <<-EOH
		cd #{node['work_dir']}
		tar zxvf #{node['cassandra']['source']['remote_file']}
	EOH
	not_if { File.exist?("#{node['nutch']['work_dir']}/#{node['cassandra']['base_name']}-#{node['cassandra']['version']}") }
	notifies :run, resources(:execute => "execute_cassandra")
	action :nothing
end

remote_file "#{node['work_dir']}/#{node['cassandra']['source']['remote_file']}" do
	source "#{node['cassandra']['source']['remote_site']}/#{node['cassandra']['source']['remote_file']}"
	notifies :run, resources(:execute => "extract_cassandra")
end