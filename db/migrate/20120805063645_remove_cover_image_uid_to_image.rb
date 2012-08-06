class RemoveCoverImageUidToImage < ActiveRecord::Migration
  def up
    remove_column :images, :cover_image_uid
  end

  def down
    add_column :images, :cover_image_uid, :string
  end
end
