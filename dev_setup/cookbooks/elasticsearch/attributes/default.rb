include_attribute "deployment"
default[:elasticsearch][:version] = "0.19.3"
default[:elasticsearch][:distribution_file] = "elasticsearch-#{node[:elasticsearch][:version]}.tar.gz"
default[:elasticsearch][:service_dir] = "/var/vcap/services/elasticsearch"
default[:elasticsearch][:http_auth_plugin] = "elasticsearch-http-basic-1.0.3.jar"

default[:elasticsearch_node][:capacity] = "200"
default[:elasticsearch_node][:index] = "0"
default[:elasticsearch_node][:max_memory] = "512"
default[:elasticsearch_node][:token] = "changeelasticsearchtoken"
