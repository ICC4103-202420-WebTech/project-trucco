class Course < ApplicationRecord
  belongs_to :instructor, class_name: 'User'
  has_many :lessons
  has_many :enrollments
  has_many :students, through: :enrollments, source: :user
  has_many :forums
  has_many :progresses


  validates :title, :description, presence: true
end
