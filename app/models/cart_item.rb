#
# カートアイテム。
#
class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item

  validates :cart_id, :item_id, presence: true
  validates_numericality_of :quantity, greater_than: 0
  validates_uniqueness_of :item_id, scope: :cart_id

  scope :search_item, lambda {|key| where(item_id: key) }

  #
  # 小計を求める。
  #
  def subtotal
    quantity * item.price
  end
end
