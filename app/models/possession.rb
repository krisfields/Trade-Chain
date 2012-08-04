class Possession < ActiveRecord::Base
  attr_accessible :description, :name, :user_id
  belongs_to :user
  has_many :images
  validates_presence_of :name, :description, :user_id
end
