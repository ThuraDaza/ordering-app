class OrderItemService
  class << self
    def get_orders
      @orders = OrderItemRepository.get_orders
    end

    def order_amount(start_date, end_date)
      @orders = OrderItemRepository.order_amount(start_date, end_date)
    end
  end
end
