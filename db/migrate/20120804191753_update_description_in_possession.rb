class UpdateDescriptionInPossession < ActiveRecord::Migration
  def change
  	change_column :possessions, :description, :textarea
  end
end
