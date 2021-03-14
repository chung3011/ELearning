class CreateUserExams < ActiveRecord::Migration[6.0]
  def change
    create_table :user_exams do |t|
      t.references :lesson, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.float :point, default: 0

      t.timestamps
    end
  end
end
