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

node.default["nutch"]["remote_site"] = "http://ftp.yz.yamagata-u.ac.jp/pub/network/apache/nutch/2.2.1"
node.default["nutch"]["remote_file"] = "apache-nutch-2.2.1-src.tar.gz"

remote_file "/tmp/#{node['nutch']['remote_file']}" do
	source "#{node['nutch']['remote_site']}/#{node['nutch']['remote_file']}"
end
