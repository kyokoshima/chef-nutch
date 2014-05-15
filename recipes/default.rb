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

include_recipe "ant::install_source"

ant_library "ant-contrib" do
		url "http://search.maven.org/remotecontent?filepath=ant-contrib/ant-contrib/20020829/ant-contrib-20020829.jar"
end

include_recipe "nutch::nutch"

include_recipe "nutch::cassandra"

include_recipe "nutch::solr"
