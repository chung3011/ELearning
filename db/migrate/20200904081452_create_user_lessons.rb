class CreateUserLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :user_lessons do |t|
      t.references :lesson, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :status, default: "nil"
      t.integer :video_status, default: 0

      t.timestamps
    end
  end
end