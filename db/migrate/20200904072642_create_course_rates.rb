class CreateCourseRates < ActiveRecord::Migration[6.0]
  def change
    create_table :course_rates do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :point

      t.timestamps
    end
  end
end
