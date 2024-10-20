class DropProgressesTable < ActiveRecord::Migration[7.2]
  def up
    drop_table :progresses
  end

  def down
    create_table :progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.integer :progress_percentage
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
