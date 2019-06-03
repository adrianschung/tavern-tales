class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.integer :map_id
      t.string :picture
      t.timestamps
    end
  end
end
