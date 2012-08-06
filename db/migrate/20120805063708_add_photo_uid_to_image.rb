class AddPhotoUidToImage < ActiveRecord::Migration
  def change
    add_column :images, :photo_uid, :string
  end
end
