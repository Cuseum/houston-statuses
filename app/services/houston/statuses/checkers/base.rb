module Houston
  module Statuses
    module Checkers
      class Base
        attr_reader :status

        def initialize(url)
          @url = URI(url)
          @status = :init
        end

        def check
          raise NotImplementedError
        end

        private

        attr_reader :url
      end
    end
  end
end
