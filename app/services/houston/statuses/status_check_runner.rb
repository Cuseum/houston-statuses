module Houston
  module Statuses
    class StatusCheckRunner
      def initialize(id)
        @status_check = StatusCheck.find(id)
      end

      def call
        result = checker_class.new(status_check.url).check
        status_check.update(
          status:          result,
          last_checked_at: Time.current
        )

        Houston.observer.fire('status_checks:checked', id: status_check.id)
      end

      private

      attr_reader :status_check

      def checker_class
        "Houston::Statuses::Checkers::#{status_check.checker}".constantize
      end
    end
  end
end
