default["java"]["install_flavor"] = "oracle"
default["java"]["jdk_version"] = "7"
default["java"]["oracle"]["accept_oracle_download_terms"] = true

default["nutch"] = {
	"source" => {
		"remote_site" => "http://ftp.yz.yamagata-u.ac.jp/pub/network/apache/nutch/2.2.1",
		"remote_file" => "apache-nutch-2.2.1-src.tar.gz"
		# 1.x
		# "remote_site" => "http://ftp.yz.yamagata-u.ac.jp/pub/network/apache/nutch/1.8",
		# "remote_file" => "apache-nutch-1.8-src.tar.gz"
	}
}

default['solr'] = {
	"source" => {
		# 4.7.x
		# "remote_site" => "http://ftp.jaist.ac.jp/pub/apache/lucene/solr/4.7.2",
		# "remote_file" => "solr-4.7.2.tgz"
		"remote_site" => "http://ftp.kddilabs.jp/infosystems/apache/lucene/solr/4.8.0",
		"remote_file" => "solr-4.8.0.tgz"
	}
}