class Image < ActiveRecord::Base
  attr_accessible :url, :possession_id, :want_id
  belongs_to :possession
  belongs_to :want
end
