class AddPossessionIdToWants < ActiveRecord::Migration
  def change
    add_column :wants, :possession_id, :integer
  end
end
