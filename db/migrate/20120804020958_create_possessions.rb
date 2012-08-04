class CreatePossessions < ActiveRecord::Migration
  def change
    create_table :possessions do |t|
      t.string :name
      t.string :description
      t.integer :user_id

      t.timestamps
    end
  end
end
