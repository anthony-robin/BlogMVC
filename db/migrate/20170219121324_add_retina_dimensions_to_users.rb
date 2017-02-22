class AddRetinaDimensionsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :retina_dimensions, :text, after: :avatar
  end
end
