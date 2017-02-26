class ActsAsCommentableWithThreadingMigration < ActiveRecord::Migration
  def change
    create_table :comments, force: true do |t|
      t.references :commentable, polymorphic: true, index: true
      t.string :title
      t.text :body
      t.string :subject
      t.integer :lft
      t.integer :rgt
      t.integer :parent_id
      t.references :user, index: true
      t.timestamps
    end
  end
end
