class Image < ActiveRecord::Base
	image_accessor :photo
  attr_accessible :possession_id, :photo
  belongs_to :possession
end
