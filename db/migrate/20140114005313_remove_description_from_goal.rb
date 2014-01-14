class RemoveDescriptionFromGoal < ActiveRecord::Migration
  def change
    remove_column :goals, :description, :string
  end
end
