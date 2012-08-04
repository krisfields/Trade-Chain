class AddValueToPossessions < ActiveRecord::Migration
  def change
    add_column :possessions, :value, :integer
  end
end
