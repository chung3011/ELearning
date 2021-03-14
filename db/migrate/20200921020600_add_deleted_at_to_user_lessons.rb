class AddDeletedAtToUserLessons < ActiveRecord::Migration[6.0]
  def change
    add_column :user_lessons, :deleted_at, :datetime
    add_index :user_lessons, :deleted_at
  end
end
