class AddDateToTrades < ActiveRecord::Migration
  def change
    add_column :trades, :date, :datetime
  end
end
