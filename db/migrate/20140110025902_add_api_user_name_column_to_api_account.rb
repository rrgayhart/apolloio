class AddApiUserNameColumnToApiAccount < ActiveRecord::Migration
  def change
    add_column :api_accounts, :api_username, :string
  end
end
