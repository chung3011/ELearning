class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :description
      t.string :video
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
