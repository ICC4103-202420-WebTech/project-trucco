class User < ApplicationRecord

    has_many :instructed_courses, class_name: 'Course', foreign_key: 'instructor_id'
    has_many :enrollments
    has_many :enrolled_courses, through: :enrollments, source: :course
    has_many :comments
    has_many :progresses

    validates :name, :email, :role, presence: true
  end
  