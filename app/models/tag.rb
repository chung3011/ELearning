class Tag < ApplicationRecord
  has_many :follow_tags, dependent: :destroy
  has_many :course_tags, dependent: :destroy
  has_many :courses, through: :course_tags

  scope :by_course, ->(course_id){
    joins(:course_tags).where('course_tags.course_id=?', course_id)
  }
end
