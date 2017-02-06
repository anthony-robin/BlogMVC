class AddCounterCacheToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :blogs_count, :integer, default: 0, null: false, after: :role
  end
end
