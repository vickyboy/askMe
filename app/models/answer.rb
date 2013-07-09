class Answer < ActiveRecord::Base
  attr_accessible :answer, :helpful, :likes, :question_id, :user_id, :votes
  
    validates :answer, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :user_id, presence: true, uniqueness: true

    belongs_to :user
    belongs_to :question
end
