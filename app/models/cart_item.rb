#
# カートアイテム。
#
class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item

  validate :enable_add_quantity
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

  private

    #
    # 指定個数の商品を追加可能か。
    #
    def enable_add_quantity
      if self.quantity > self.item.stock
        errors.add(:quantity, :not_enable_add_item)
      end
    end
end
