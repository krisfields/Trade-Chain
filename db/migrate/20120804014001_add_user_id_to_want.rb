class AddUserIdToWant < ActiveRecord::Migration
  def change
    add_column :wants, :user_id, :integer
  end
end
