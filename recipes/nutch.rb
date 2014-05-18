execute "start_crawl" do
	command <<-EOH
		cd #{node['work_dir']}/#{node['nutch']['base_name']}-#{node['nutch']['version']}/runtime/local
		bin/crawl urls crawl/crawldb http://localhost:8983/solr 1
	EOH
	action :nothing
end

execute "seed_create" do
	command <<-EOH
		cd #{node['work_dir']}/#{node['nutch']['base_name']}-#{node['nutch']['version']}/runtime/local
		mkdir urls
		echo 'http://news.yahoo.co.jp/' >> urls/seed.txt
	EOH
	action :nothing
	not_if { File.exist?("#{node['nutch']['work_dir']}/#{node['nutch']['base_name']}-#{node['nutch']['version']}/runtime/local/urls") }
	notifies :run, resources(:execute => "start_crawl")
end

execute "ant-build" do
	command <<-EOH
		cd #{node['work_dir']}/#{node['nutch']['base_name']}-#{node['nutch']['version']}
		ant clean runtime
	EOH
	action :nothing
	notifies :run, resources(:execute => "seed_create")
end
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
	notifies :run, resources(:execute=> "ant-build")
	not_if { File.exist?("#{node['nutch']['work_dir']}/#{node['nutch']['base_name']}-#{node['nutch']['version']}") }
	action :nothing
end
remote_file "#{node['work_dir']}/#{node['nutch']['source']['remote_file']}" do
	source "#{node['nutch']['source']['remote_site']}/#{node['nutch']['source']['remote_file']}"
	notifies :run, resources(:execute=>"extract_nutch")
end