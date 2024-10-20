class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :set_default_role, on: :create
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :instructed_courses, class_name: 'Course', foreign_key: 'instructor_id'
    has_many :enrollments
    has_many :enrolled_courses, through: :enrollments, source: :course
    has_many :comments

    validates :name, :email, :role, presence: true
    private

    def set_default_role
      self.role ||= 'student' # Set the default role to 'student' if not provided
    end
  end
  