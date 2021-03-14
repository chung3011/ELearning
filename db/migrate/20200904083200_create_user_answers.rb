class CreateUserAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :user_answers do |t|
      t.references :answer, null: false, foreign_key: true
      t.references :user_exam, null: false, foreign_key: true

      t.timestamps
    end
  end
end
