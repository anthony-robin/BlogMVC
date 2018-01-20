# This migration comes from acts_as_taggable_on_engine (originally 1)
class ActsAsTaggableOnMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name, index: { unique: true }
      t.integer :taggings_count, default: 0

      t.timestamps
    end

    create_table :taggings do |t|
      t.references :tag, index: true
      t.references :taggable, polymorphic: true, index: true
      t.references :tagger, polymorphic: true, index: true
      t.string :context, limit: 128, index: true

      t.timestamps
    end

    ActsAsTaggableOn::Tag.reset_column_information
    ActsAsTaggableOn::Tag.find_each do |tag|
      ActsAsTaggableOn::Tag.reset_counters(tag.id, :taggings)
    end
  end
end
