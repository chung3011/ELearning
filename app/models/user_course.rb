class UserCourse < ApplicationRecord
  acts_as_paranoid
  belongs_to :course
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :course_id, :message=>"Already register this course"
end
