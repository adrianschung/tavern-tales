class AddPictureToMaps < ActiveRecord::Migration[5.2]
  def change
    add_column :maps, :picture, :string
  end
end
