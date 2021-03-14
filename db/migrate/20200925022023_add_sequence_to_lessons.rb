class AddSequenceToLessons < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :sequence, :integer
  end
end
