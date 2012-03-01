#this class describes in a declarative manner the policy that HealthManager2 is implementing.
#it describes a set of rules that recognize certain conditions (e.g. missing instances, etc) and
#initiates certain actions (e.g. restarting the missing instances)

module HealthManager2
  class Harmonizer
    def initialize(config = {})
      @config = config
    end
    def prepare
      #set system-wide configurations
      AppState.analysis_delay_after_reset = get_interval_from_config_or_constant(:analysis_delay, @config)

      #set up listeners for anomalous events to respond with correcting actions
      AppState.add_listener(:instances_missing) do |app_state|
        nudger.start_instances(app_state)
      end

      #schedule time-based actions
      scheduler.at_interval :request_queue do
        nudger.deque_batch_of_requests
      end

      scheduler.at_interval :expected_state_update do
        expected_state_provider.each_droplet do |app_id, expected|
          known = known_state_provider.get_droplet(app_id)
          expected_state_provider.set_expected_state(known, expected)
        end
      end

      scheduler.at_interval :droplet_analysis do
        known_state_provider.rewind
        scheduler.start_task :droplet_analysis do
          known_droplet = known_state_provider.next_droplet
          if known_droplet
            known_droplet.analyze
          else
            nil
          end
        end
      end
    end

    private
    def scheduler
      find_hm_component(:scheduler, @config)
    end
    def nudger
      find_hm_component(:nudger, @config)
    end
    def known_state_provider
      find_hm_component(:known_state_provider, @config)
    end
    def expected_state_provider
      find_hm_component(:expected_state_provider, @config)
    end
  end
end
