class CreateApiAccounts < ActiveRecord::Migration
  def change
    create_table :api_accounts do |t|
      t.references :user, index: true
      t.references :api, index: true

      t.timestamps
    end
  end
end
