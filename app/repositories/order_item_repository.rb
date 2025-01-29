class OrderItemRepository
  class << self
    def get_orders
      @orders = Order.all.select { |order| order.status != "finished" && order.status != "pickup" }
    end

    def order_amount(start_date, end_date)
      @orders = OrderItem.find_by_sql(
        "SELECT item_name, created_at, SUM(quantity) as total 
        FROM order_items 
        WHERE created_at BETWEEN '#{start_date} 00:00:00' AND '#{end_date} 23:59:59'
        GROUP BY item_name
        ORDER BY total DESC
        LIMIT 7" 
      )
    end
  end
end
