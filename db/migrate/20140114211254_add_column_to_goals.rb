class AddColumnToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :active, :boolean, default: true
  end
end
