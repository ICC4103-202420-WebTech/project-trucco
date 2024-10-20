class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  attribute :progress_percentage, :integer, default: 0
  attribute :completed, :boolean, default: false

  validates :user_id, :course_id, presence: true
  validates :progress_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :completed, inclusion: { in: [true, false] }
end
