class CreateTradingHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :trading_histories do |t|
      t.string :name
      t.decimal :unit_price, precision:5, scale: 2
      t.integer :shares
      t.integer :user_id
      t.integer :stock_id
      t.string :transaction_type
      t.timestamps
    end
  end
end
