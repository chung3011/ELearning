class Answer < ApplicationRecord
  belongs_to :question
  has_many :user_answers

  validates :content, presence: true
  validates :point, presence: true
end
