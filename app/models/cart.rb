#
# カート。
#
class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy

  #
  # 総価格。
  #
  def total_items_price
    self.cart_items.to_a.sum(&:subtotal)
  end
end
