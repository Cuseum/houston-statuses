module Houston
  module Statuses
    module Checkers
      class StatuspageIoChecker < Base
        def check
          resp = Faraday.get(url)
          body = JSON.parse(resp.body)

          @status = indicator_to_status(body['status']['indicator'])
        end

        private

        def indicator_to_status(indicator)
          case indicator
          when 'operational', 'none'
            :operational
          when 'maintenance', 'degraded_performance'
            :warn
          else
            :outage
          end
        end
      end
    end
  end
end
