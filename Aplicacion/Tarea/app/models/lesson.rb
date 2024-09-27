class Lesson < ApplicationRecord
  belongs_to :course
  has_many :progresses
  has_rich_text :content_rich_text

  validates :title, :content_type, presence: true
end
