class AddUrlToPhotos < ActiveRecord::Migration[8.0]
  def change
    add_column :photos, :url, :string
  end
end
