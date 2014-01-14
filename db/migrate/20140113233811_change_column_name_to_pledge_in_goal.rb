class ChangeColumnNameToPledgeInGoal < ActiveRecord::Migration
  def change
    rename_column :goals, :name, :pledge
  end
end
