module Houston::Statuses
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
