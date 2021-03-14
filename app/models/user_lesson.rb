class UserLesson < ApplicationRecord
  acts_as_paranoid
  belongs_to :lesson
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :lesson_id, :message=>"already join this lesson"
end
