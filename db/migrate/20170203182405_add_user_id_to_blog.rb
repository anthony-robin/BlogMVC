class AddUserIdToBlog < ActiveRecord::Migration[5.0]
  def change
    add_reference :blogs, :user, index: true, foreign_key: true, after: :content
  end
end
