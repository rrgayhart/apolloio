class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.references :user, index: true
      t.integer :target
      t.integer :period
      t.string :period_type
      t.date :start_date

      t.timestamps
    end
  end
end
