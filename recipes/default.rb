#
# Cookbook Name:: nutch
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
include_recipe "java"

# node.default["nutch"]["remote_site"] = "http://ftp.yz.yamagata-u.ac.jp/pub/network/apache/nutch/2.2.1"
# node.default["nutch"]["remote_file"] = "apache-nutch-2.2.1-src.tar.gz"

remote_file "/tmp/#{node['nutch']['source']['remote_file']}" do
	source "#{node['nutch']['source']['remote_site']}/#{node['nutch']['source']['remote_file']}"
end

include_recipe "ant::install_source"

ant_library "ant-contrib" do
		url "http://search.maven.org/remotecontent?filepath=ant-contrib/ant-contrib/20020829/ant-contrib-20020829.jar"
end

remote_file "/tmp/#{node['solr']['source']['remote_file']}" do
	source "#{node['solr']['source']['remote_site']}/#{node['solr']['source']['remote_file']}"
end
