class AddTradeIdToPossessions < ActiveRecord::Migration
  def change
    add_column :possessions, :trade_id, :integer
  end
end
