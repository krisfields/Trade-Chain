class Want < ActiveRecord::Base
  attr_accessible :description, :name, :value, :user_id
  belongs_to :user
  has_many :images
  validates_presence_of :name, :description, :value, :user_id
end
