class AddCounterCacheToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :blogs_count, :integer, default: 0, null: false, after: :slug
  end
end
