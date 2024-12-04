class AddPositionToPhotos < ActiveRecord::Migration[8.0]
  def change
    add_column :photos, :position, :integer
  end
end
