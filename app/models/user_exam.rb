class UserExam < ApplicationRecord
  belongs_to :lesson
  belongs_to :user
  has_many :user_answers
  has_many :answers, through: :user_answers

  accepts_nested_attributes_for :user_answers
end
