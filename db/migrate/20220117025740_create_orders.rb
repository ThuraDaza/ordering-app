class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.integer :total_price

      t.timestamps
    end
    add_reference(:orders, :waiter, foreign_key: true)
  end
end
