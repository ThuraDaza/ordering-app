class OrderRepository
  class << self
    def get_order_by_id(id)
      @order = Order.find_by(id: id)
    end

    def update_status_process
      @order.update(status: "processing")
    end

    def update_status_finish
      @order.update(status: "finished")
    end

    def update_status(id, status)
      @order = Order.find(id)
      @update_order = @order.update(status: status)
    end
  end
end
