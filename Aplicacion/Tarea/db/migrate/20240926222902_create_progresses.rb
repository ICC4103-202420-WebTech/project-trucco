class CreateProgresses < ActiveRecord::Migration[7.2]
  def change
    create_table :progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.decimal :progress_percentage
      t.boolean :completed

      t.timestamps
    end
  end
end
