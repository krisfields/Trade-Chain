class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :giver
      t.integer :receiver
      t.integer :trade_id

      t.timestamps
    end
  end
end
