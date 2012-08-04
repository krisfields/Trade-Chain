class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

	rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  has_many :wants
  has_many :possessions
  validates_uniqueness_of :name
  # def to_param
  #   self.name
  # end
end
