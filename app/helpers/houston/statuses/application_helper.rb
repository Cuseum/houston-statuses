module Houston::Statuses
  module ApplicationHelper
    def status_check_status_label_class(status)
      case status.to_sym
      when :operational then 'label-success'
      when :warn then 'label-warning'
      when :outage then 'label-important'
      end
    end
  end
end
