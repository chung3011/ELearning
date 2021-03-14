class CourseRate < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :point,
    presence: true

  scope :newest, ->{order(created_at: :desc)}
end
