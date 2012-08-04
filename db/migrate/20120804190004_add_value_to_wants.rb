class AddValueToWants < ActiveRecord::Migration
  def change
    add_column :wants, :value, :integer
  end
end
