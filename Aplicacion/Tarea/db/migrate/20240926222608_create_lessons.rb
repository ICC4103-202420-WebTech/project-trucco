class CreateLessons < ActiveRecord::Migration[7.2]
  def change
    create_table :lessons do |t|
      t.references :course, null: false, foreign_key: true
      t.string :title
      t.string :content_type
      t.text :content

      t.timestamps
    end
  end
end
