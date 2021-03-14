class CreateCourseComments < ActiveRecord::Migration[6.0]
  def change
    create_table :course_comments do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
