class CourseComment < ApplicationRecord
  belongs_to :course
  belongs_to :user

  scope :newest, ->{order(created_at: :desc)}
end
