class RemoveRetinaDimensionsFromPictures < ActiveRecord::Migration[5.1]
  def change
    remove_column :pictures, :retina_dimensions, :text
  end
end
