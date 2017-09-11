class SorceryCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      ## Core
      t.string :email, null: false, index: true, unique: true
      t.string :username, null: false
      t.string :slug, null: false, index: true, unique: true
      t.string :crypted_password
      t.string :salt

      ## Rememberable
      t.string :remember_me_token, default: nil, index: true
      t.datetime :remember_me_token_expires_at, default: nil

      ## Reset password
      t.string :reset_password_token, default: nil, index: true, unique: true
      t.datetime :reset_password_token_expires_at, default: nil
      t.datetime :reset_password_email_sent_at, default: nil

      t.timestamps null: false
    end
  end
end
