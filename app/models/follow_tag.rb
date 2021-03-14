class FollowTag < ApplicationRecord
  belongs_to :user
  belongs_to :tag

  validates_uniqueness_of :user_id, scope: :tag_id, :message=>"Already follow this tag"
end
