class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.references :attachable, polymorphic: true
      t.string :image
      t.text :retina_dimensions

      t.timestamps
    end
  end
end
