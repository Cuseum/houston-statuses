module Houston::Statuses
  class StatusCheck < ApplicationRecord
    enum status: [:init, :operational, :warn, :outage]

    validates :name, presence: true, uniqueness: true
    validates :url, presence: true
    validates :checker, presence: true
  end
end
