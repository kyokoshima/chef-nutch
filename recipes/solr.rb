execute "execute_solr" do
	command <<-EOH
		cd #{node['work_dir']}/#{node['solr']['base_name']}-#{node['solr']['version']}/example
		sudo nohup java -jar start.jar &
	EOH
	not_if "pgrep -fl start.jar"
	action :nothing
end

template "schema-solr4.xml" do
	source "schema-solr4.xml.erb"
	path "#{node['work_dir']}/#{node['solr']['base_name']}-#{node['solr']['version']}/example/solr/collection1/conf/schema.xml"
	action :nothing
	notifies :run, resources(:execute => 'execute_solr')
end

execute "extract_solr" do
	command <<-EOH
		cd #{node['work_dir']}
		tar zxvf #{node['solr']['source']['remote_file']}
	EOH
	# not_if { File.exist?("#{node['nutch']['work_dir']}/#{node['solr']['base_name']}-#{node['solr']['version']}") }
	action :nothing
	notifies :create, resources(:template => 'schema-solr4.xml')
end

remote_file "#{node['work_dir']}/#{node['solr']['source']['remote_file']}" do
	source "#{node['solr']['source']['remote_site']}/#{node['solr']['source']['remote_file']}"
	notifies :run, resources(:execute => 'extract_solr')
end

