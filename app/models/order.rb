#
# 注文
#
class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items

  validates :date, :destination_zip_code, :destination_address, :destination_name, :payment_method, presence: true
  validate :validate_deliverable_delivery_date

  extend Enumerize
  enumerize :payment_method, in: { cash_on_delivery: 1 }
  enumerize :delivery_time_zone, in: { zone_8_12: 1, zone_12_14: 2, zone_14_16: 3, zone_16_18: 4, zone_18_20: 5, zone_20_21: 6 }

  before_create :generate_order_number

  #
  # 注文を確定する。
  #
  def decided(cart)
    self.transaction do
      cart.cart_items.each do |cart_item|
        self.order_items << self.order_items.build({ item_id: cart_item.item_id, price: cart_item.item.price, quantity: cart_item.quantity })
        cart_item.item.remove_stock!(cart_item.quantity)
      end

      cart.destroy

      self.date = DateTime.now
      self.save!
    end
  rescue
    false
  end

  private

  #
  # 注文番号を生成する。
  #
  def generate_order_number
    self.order_number = loop do
      token = SecureRandom.uuid
      break token unless Order.exists?(order_number: token)
    end
  end

  #
  # 配送日が配送可能な日になっているかどうかを検証する。
  #
  def validate_deliverable_delivery_date
    return if self.delivery_date.nil?

    today = Date.today
    if self.delivery_date <= today
      errors.add(:delivery_date, :deliverable_delivery_date)
      return
    end
    
    business_days = (today...self.delivery_date).select{ |date| (date.sunday? and date.saturday?) }.size
    if business_days < 3 or business_days > 14
      errors.add(:delivery_date, :deliverable_delivery_date)
    end
  end
end
