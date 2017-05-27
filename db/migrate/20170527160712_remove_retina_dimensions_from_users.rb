class RemoveRetinaDimensionsFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :retina_dimensions, :text
  end
end
