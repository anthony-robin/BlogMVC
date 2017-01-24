class AddCategoryIdToBlog < ActiveRecord::Migration[5.0]
  def change
    add_reference :blogs, :category, foreign_key: true, after: :content
  end
end
