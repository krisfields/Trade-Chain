class Result < ActiveRecord::Base
  attr_accessible :giver, :receiver, :trade_id
  belongs_to :trade
end
