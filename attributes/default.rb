default["java"]["install_flavor"] = "oracle"
default["java"]["jdk_version"] = "7"
default["java"]["oracle"]["accept_oracle_download_terms"] = true

default['work_dir'] = '/tmp'
default['nutch'] = {
		'version' => '2.2.1',
		'base_name' => 'apache-nutch',
		'ext' => 'src.tar.gz'
}
default['solr'] = {
		'version' => '4.8.0',
		'base_name' => 'solr',
		'ext' => 'tgz'
}
default['cassandra'] = {
		'version' => '2.0.7',
		'base_name' => 'apache-cassandra',
		'ext' => 'bin.tar.gz'
}

default["nutch"]['source'] = {
		"remote_site" => "http://ftp.yz.yamagata-u.ac.jp/pub/network/apache/nutch/#{node['nutch']['version']}",
		"remote_file" => "#{node['nutch']['base_name']}-#{node['nutch']['version']}-#{node['nutch']['ext']}"
		# 1.x
		# "remote_site" => "http://ftp.yz.yamagata-u.ac.jp/pub/network/apache/nutch/1.8",
		# "remote_file" => "apache-nutch-1.8-src.tar.gz"
}

default['solr']['source'] = {
		# 4.7.x
		# "remote_site" => "http://ftp.jaist.ac.jp/pub/apache/lucene/solr/4.7.2",
		# "remote_file" => "solr-4.7.2.tgz"
		"remote_site" => "http://ftp.kddilabs.jp/infosystems/apache/lucene/solr/#{node['solr']['version']}",
		"remote_file" => "#{node['solr']['base_name']}-#{node['solr']['version']}.#{node['solr']['ext']}"
}

default['cassandra']['source'] = {
		"remote_site" => "http://ftp.riken.jp/net/apache/cassandra/#{node['cassandra']['version']}",
		"remote_file" => "#{node['cassandra']['base_name']}-#{node['cassandra']['version']}-#{node['cassandra']['ext']}",
}