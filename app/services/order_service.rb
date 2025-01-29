class OrderService
  class << self
    def get_order_by_id(id)
      @order = OrderRepository.get_order_by_id(id)
    end

    def update_status_process
      @order = OrderRepository.update_status_process
    end

    def update_status_finish
      @order = OrderRepository.update_status_finish
    end

    def update_status(id, status)
      @update_order = OrderRepository.update_status(id, status)
    end
  end
end
