class CreateHoustonStatusesStatusChecks < ActiveRecord::Migration[5.0]
  def change
    create_table :houston_statuses_status_checks do |t|
      t.string :name
      t.string :url
      t.string :checker
      t.integer :status
      t.datetime :last_checked_at

      t.timestamps
    end
    add_index :houston_statuses_status_checks, :name, unique: true
  end
end
