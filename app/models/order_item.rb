#
# 注文商品
#
class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  validates :item_id, :price, :quantity, presence: true
  validates_numericality_of :quantity, greater_than: 0
  validates_uniqueness_of :item_id, scope: :order_id

  #
  # 小計を求める。
  #
  def subtotal
    quantity * price
  end
end
