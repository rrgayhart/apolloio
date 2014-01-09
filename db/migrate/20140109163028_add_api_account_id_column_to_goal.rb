class AddApiAccountIdColumnToGoal < ActiveRecord::Migration
  def change
    add_reference :goals, :api_account, index: true
  end
end
