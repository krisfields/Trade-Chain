class AddPossessionIdToWants < ActiveRecord::Migration
  def change
    add_column :wants, :possession_id, :integer
    remove_column :wants, :name
    remove_column :wants, :description
  end
end
