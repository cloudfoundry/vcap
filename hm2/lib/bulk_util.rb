$:.unshift(File.join(File.dirname(__FILE__)))

require 'rubygems'
require 'health_manager2'

include HealthManager2

trap('INT') { NATS.stop { EM.stop }}
trap('SIGTERM') { NATS.stop { EM.stop }}

EM::run {

  NATS.start :uri => ENV['NATS_URI'] || 'nats://nats:nats@192.168.24.128:4222' do
    config = {
      'bulk' => {'host'=> 'api.vcap.me', 'batch_size' => '2'},
    }
    VCAP::Logging.setup_from_config({'level'=>ENV['LOG_LEVEL'] || 'debug'})

    prov = BulkBasedExpectedStateProvider.new(config)
    prov.each_droplet do |id, droplet|
      puts "Droplet #{id}:"
      puts droplet.inspect
    end
  end
}
