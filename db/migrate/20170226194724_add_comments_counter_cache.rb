class AddCommentsCounterCache < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :comments_count, :integer, default: 0, null: false, after: :blogs_count
    add_column :blogs, :comments_count, :integer, default: 0, null: false, after: :content
  end
end
