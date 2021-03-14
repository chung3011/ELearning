class CourseTag < ApplicationRecord
  belongs_to :course
  belongs_to :tag

  scope :by_ids, ->(ids){where(tag_id: ids).distinct}
end
