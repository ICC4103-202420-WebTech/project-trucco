class Forum < ApplicationRecord
  belongs_to :course
  has_many :comments, dependent: :destroy

  validates :title, presence: true
end
