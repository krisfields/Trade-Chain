class Want < ActiveRecord::Base
  attr_accessible :value, :user_id, :possession_id
  belongs_to :user
  belongs_to :possession, :counter_cache => true
  validates_presence_of :value, :user_id, :possession_id
end
