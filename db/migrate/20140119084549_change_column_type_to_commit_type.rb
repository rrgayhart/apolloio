class ChangeColumnTypeToCommitType < ActiveRecord::Migration
  def change
    rename_column :goals, :type, :commit_type
  end
end
