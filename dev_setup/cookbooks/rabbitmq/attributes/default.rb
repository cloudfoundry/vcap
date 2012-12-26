include_attribute "deployment"
include_attribute "service"

default[:rabbitmq][:supported_versions] = {
        "2.4" => "2.4.1",
        "2.8" => "2.8.7",
}
default[:rabbitmq][:version_aliases] = {
        "deprecated" => "2.8",
        "current"    => "2.4",
}
default[:rabbitmq][:default_version] = "2.8"

default[:rabbitmq][:path] = File.join(node[:service][:path], "rabbitmq")
default[:rabbitmq][:id] = {
  "2.4.1" => "eyJzaWciOiJOTWRVQm01RHU3c1RXcHF4dUovUm93S1c0UUU9Iiwib2lkIjoi%0ANGU0ZTc4YmNhNDFlMTIxMjA0ZTRlODZlZTUzOTIxMDUwMTlmYTU0YWRkZTEi%0AfQ==%0A",
  "2.8.7" => "eyJvaWQiOiI0ZTRlNzhiY2E0MWUxMjEwMDRlNGU3ZDUxNzYxOGYwNTBiMzI2%0ANzM2ODZlZCIsInNpZyI6IjkwaDNnYnRuUzJKTXhSZmpVSlZxanUwT1RRYz0i%0AfQ==%0A",
}

default[:rabbitmq][:checksum] = {
  "2.4.1" => "0a87dfe4489b0ddabfee7306536530934a4d4518ef0821e08634c7a07d4cf732",
  "2.8.7" => "7a177c541ad6a33d639330d09503d0948e77208323bd8e603c48e40cd041a432",
}

default[:rabbitmq][:erlang_id] = "eyJzaWciOiJIb2RpNmdVdnp0S2VHSGRtRUxYQ3dGWnc3WHM9Iiwib2lkIjoi%0ANGU0ZTc4YmNhMzFlMTIxMDA0ZTRlN2Q1MTQ3NDVmMDUwNTljZDgxMmY5YWMi%0AfQ==%0A"
default[:rabbitmq][:erlang_checksum] = "4c72446596803e8a41ec06e7bee5e840d81756f25613bbe3042609c7d0cb0d6b"

default[:rabbitmq_gateway][:service][:timeout] = "25"
default[:rabbitmq_gateway][:node_timeout] = "20"

default[:rabbitmq_node][:index] = "0"
default[:rabbitmq_node][:token] = "changerabbitmqtoken"
default[:rabbitmq_node][:op_time_limit] = "15"
default[:rabbitmq_node][:rabbitmq_start_timeout] = "10"

default[:rabbitmq_node][:govendor_repo] = "git://github.com/cloudfoundry/govendor.git"
