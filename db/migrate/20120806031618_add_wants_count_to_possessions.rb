class AddWantsCountToPossessions < ActiveRecord::Migration
  def change
    add_column :possessions, :wants_count, :integer
  end
end
