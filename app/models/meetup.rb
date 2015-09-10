class Meetup < ActiveRecord::Base
  has_many :usermeetups
  has_many :users, through: :usermeetups
  validates :title, presence: true, uniqueness: true, length: { maximum: 50} 

end
