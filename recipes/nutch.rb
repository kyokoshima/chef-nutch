template "nutch-site.xml" do
	source "nutch-site.xml.erb"
	path "#{node['work_dir']}/#{node['nutch']['base_name']}-#{node['nutch']['version']}/conf/nutch-site.xml"
	action :nothing
end
template "gora.properties" do
	source "gora.properties.erb"
	path "#{node['work_dir']}/#{node['nutch']['base_name']}-#{node['nutch']['version']}/conf/gora.properties"
	action :nothing
end
template "ivy.xml" do
	source "ivy.xml.erb"
	path "#{node['work_dir']}/#{node['nutch']['base_name']}-#{node['nutch']['version']}/ivy/ivy.xml"
	action :nothing
end
execute "extract_nutch" do
	cwd node['nutch']['work_dir']
	command <<-EOH
		cd #{node['work_dir']}
		tar zxvf #{node['nutch']['source']['remote_file']}
	EOH
	notifies :create, resources(:template=>"nutch-site.xml")
	notifies :create, resources(:template=>"gora.properties")
	notifies :create, resources(:template=>"ivy.xml")
	not_if { File.exist?("#{node['nutch']['work_dir']}/#{node['nutch']['base_name']}-#{node['nutch']['version']}") }
	action :nothing
end
remote_file "#{node['work_dir']}/#{node['nutch']['source']['remote_file']}" do
	source "#{node['nutch']['source']['remote_site']}/#{node['nutch']['source']['remote_file']}"
	notifies :run, resources(:execute=>"extract_nutch")
end