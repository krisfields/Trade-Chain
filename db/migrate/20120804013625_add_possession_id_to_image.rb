class AddPossessionIdToImage < ActiveRecord::Migration
  def change
    add_column :images, :possession_id, :integer
  end
end
