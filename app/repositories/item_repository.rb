class ItemRepository
  class << self
    def create_item(item)
      @is_item_create = item.save
    end

    def get_item_by_id(id)
      @item = Item.find(id)
    end

    def get_item_by_category(cat)
      @items = Item.where(category: cat)
    end

    def delete_item(id)
      @item.destroy
    end
  end
end
