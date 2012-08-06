class RemovePhotoFileNameFromImages < ActiveRecord::Migration
  def up
    remove_column :images, :photo_file_name
    remove_column :images, :photo_content_type
    remove_column :images, :photo_file_size
    remove_column :images, :photo_updated_at
  end

  def down
    add_column :images, :photo_file_name, :string
    add_column :images, :photo_content_type, :string
    add_column :images, :photo_file_size, :integer
    add_column :images, :photo_updated_at, :datetime
  end
end
