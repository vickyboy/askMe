class Question < ActiveRecord::Base

  attr_accessible :helpful, :likes, :question, :user_id, :votes
  
  validates :question, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :user_id, presence: true
  belongs_to :user
  has_many :answers, :dependent => :destroy
end
