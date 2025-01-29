class Order < ApplicationRecord
  belongs_to :waiter
  has_many :order_items
end
