class AddMoodToUser < ActiveRecord::Migration
  def change
    add_column :users, :mood, :string
  end
end
