class Possession < ActiveRecord::Base
  attr_accessible :description, :name, :value, :user_id, :trade_id, :owner_id
  belongs_to :user
  belongs_to :trade
  has_many :images
  has_many :wants
  validates_presence_of :name, :description, :value, :user_id
end
