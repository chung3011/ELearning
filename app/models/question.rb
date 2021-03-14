class Question < ApplicationRecord
  belongs_to :lesson
  has_many :answers, dependent: :destroy, inverse_of: :question

  validates :content, presence: true
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
end
