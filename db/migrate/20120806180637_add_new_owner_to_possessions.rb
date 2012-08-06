class AddNewOwnerToPossessions < ActiveRecord::Migration
  def change
    add_column :possessions, :new_owner, :integer
  end
end
