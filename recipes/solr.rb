remote_file "#{node['work_dir']}/#{node['solr']['source']['remote_file']}" do
	source "#{node['solr']['source']['remote_site']}/#{node['solr']['source']['remote_file']}"
end

execute "extract_solr" do
	command <<-EOH
		cd #{node['work_dir']}
		tar zxvf #{node['solr']['source']['remote_file']}
	EOH
	not_if { File.exist?("#{node['nutch']['work_dir']}/#{node['solr']['base_name']}-#{node['solr']['version']}") }
end