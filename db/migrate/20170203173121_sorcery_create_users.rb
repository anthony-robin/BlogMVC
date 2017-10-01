class SorceryCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      ## Core
      t.string :email, null: false, index: true, unique: true
      t.string :username, null: false
      t.string :slug, null: false, index: true, unique: true
      t.string :crypted_password
      t.string :salt

      t.timestamps null: false
    end
  end
end
