class Course < ApplicationRecord
  has_many :lessons
  has_many :course_tags
  has_many :course_comments
  has_many :course_rates
  has_many :user_courses
  has_many :tags, through: :course_tags
  has_many :users, through: :user_courses
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true

  scope :most_popular, ->{
    joins(:user_courses).group(:id).order('COUNT(user_courses.user_id) DESC').where(available: true)
  }
  scope :newest, ->{where(available: true).order(created_at: :desc)}
  scope :get_courses, ->(name){where(available: true).where("name like ?", "%#{name}%")}
  scope :by_ids, ->(ids){where(available: true).where(id: ids)}
  scope :available, ->{where available: true}

  accepts_nested_attributes_for :lessons, reject_if: :all_blank
end
