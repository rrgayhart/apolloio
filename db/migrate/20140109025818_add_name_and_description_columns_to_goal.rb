class AddNameAndDescriptionColumnsToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :name, :string
    add_column :goals, :description, :string
  end
end
