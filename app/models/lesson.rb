class Lesson < ApplicationRecord
  belongs_to :course
  has_many :questions, dependent: :destroy, inverse_of: :lesson
  has_many :user_lessons
  has_many :user_exams
  has_many :users, through: :user_lessons

  validates :name, presence: true
  validates :description, presence: true
  validates :video, presence: true

  scope :by_sequence, ->{order(sequence: :asc)}

  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
end
