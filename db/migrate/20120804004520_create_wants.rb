class CreateWants < ActiveRecord::Migration
  def change
    create_table :wants do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
