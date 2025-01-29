class ItemService
  class << self
    def create_item(item)
      @is_item_create = ItemRepository.create_item(item)
    end

    def get_item_by_id(id)
      @item = ItemRepository.get_item_by_id(id)
    end

    def get_item_by_category(cat)
      @items = ItemRepository.get_item_by_category(cat)
    end

    def delete_item
      @item = ItemRepository.delete_item(:id)
    end
  end
end
