class AddWantIdToImage < ActiveRecord::Migration
  def change
    add_column :images, :want_id, :integer
  end
end
