class RemoveWantIdFromImages < ActiveRecord::Migration
  def up
    remove_column :images, :want_id
  end

  def down
    add_column :images, :want_id, :string
  end
end
