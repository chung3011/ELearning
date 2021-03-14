class AddIndexToUsersMail < ActiveRecord::Migration[6.0]
  def change
	add_index :users, :mail, unique: true
  end
end
