class AddUserDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_approved, :boolean, default:false
    add_column :users, :first_name, :string , null: false
    add_column :users, :last_name, :string, null: false
  end
end
