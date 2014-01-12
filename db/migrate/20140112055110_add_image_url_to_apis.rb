class AddImageUrlToApis < ActiveRecord::Migration
  def change
    add_column :apis, :image_url, :string, default: "default.jpg"
  end
end
