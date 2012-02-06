class CreateHolidayObserveds < ActiveRecord::Migration
  def self.up
    create_table :holiday_observeds do |t|
      t.integer :profile_id
      t.date :holiday_date
      t.string :holiday_name
      t.string :holiday_description
      t.timestamps
    end
  end

  def self.down
    drop_table :holiday_observeds
  end
end
