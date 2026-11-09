class Course < ApplicationRecord
  belongs_to :instructor, class_name: 'User'
  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user
  has_many :forums, dependent: :destroy


  validates :title, :description, presence: true
end
