class AddLanguageToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :language, :string
  end
end
