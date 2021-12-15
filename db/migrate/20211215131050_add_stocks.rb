class AddStocks < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :name,:string
    add_column :stocks, :unit_price,:integer
    add_column :stocks, :shares,:integer
    add_column :stocks, :user_id,:integer, null: false
  end
end
