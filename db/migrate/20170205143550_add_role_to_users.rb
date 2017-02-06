class AddRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :integer, after: :last_sign_in_ip, default: 2
  end
end
