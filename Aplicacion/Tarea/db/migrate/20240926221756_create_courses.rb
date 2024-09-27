class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses do |t|
      t.references :instructor, null: false, foreign_key: { to_table: :users }
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
