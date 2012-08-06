class AddCoverImageUidToImage < ActiveRecord::Migration
  def change
    add_column :images, :cover_image_uid, :string
  end
end
