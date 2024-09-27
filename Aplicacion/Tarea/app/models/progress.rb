class Progress < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :lesson

  validates :progress_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :completed, inclusion: { in: [true, false] }
end
