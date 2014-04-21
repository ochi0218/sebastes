#
# 注文
#
class Order < ActiveRecord::Base
  # 送料
  DELIVERY_FEE = 600.freeze
  # 送料がかかる個数
  DELIVERY_FEE_PER_QUANTITY = 5.freeze
  # 手数料(0-10,000未満)
  FEE_0_to_10_000 = 315.freeze
  # 手数料(10,000-30,000未満)
  FEE_10_000_to_30_000 = 420.freeze
  # 手数料(30,000-100,000未満)
  FEE_30_000_to_100_000 = 630.freeze
  # 手数料(100,000以上)
  FEE_OVER_100_000 = 1_050.freeze

  belongs_to :user
  has_many :order_items

  validate :validate_available_use_point
  validate :validate_deliverable_delivery_date
  validates :destination_zip_code, :destination_address, :destination_name, :payment_method, presence: true
  validates_numericality_of :use_point, greater_than: 0, allow_blank: true
  validates_numericality_of :fee, :delivery_fee, greater_than_or_equal_to: 0

  scope :by_newest, -> { order(updated_at: :desc) }
  scope :by_order_date, -> { order(date: :desc) }
  default_scope by_newest

  extend Enumerize
  enumerize :payment_method, in: { cash_on_delivery: 1 }
  enumerize :delivery_time_zone, in: { zone_8_12: 1, zone_12_14: 2, zone_14_16: 3, zone_16_18: 4, zone_18_20: 5, zone_20_21: 6 }

  before_create :generate_order_number, :set_order_date

  #
  # ユーザとカートからインスタンスを生成する。
  #
  def self.from_user_with_cart(user, cart)
    Order.new.tap {|order|
      order.user = user
      order.destination_zip_code = user.destination_zip_code
      order.destination_address = user.destination_address
      order.destination_name = user.destination_name

      order.with_cart(cart)
    }
  end

  #
  # カート情報を付与する。
  #
  def with_cart(cart)
    cart.cart_items.each do |cart_item|
      item = cart_item.item

      self.order_items << self.order_items.build({ item_id: item.id, price: item.price, quantity: cart_item.quantity })
    end

    self.fee = calc_fee(cart)
    self.delivery_fee = calc_delivery_fee(cart)
    self
  end

  #
  # 注文を確定する。
  #
  def decided!
    self.transaction do
      decide_order_items!

      self.save!
    end
  end

  #
  # 商品の総価格。
  #
  def total_items_price
    self.order_items.to_a.sum(&:subtotal)
  end

  #
  # 総価格。
  #
  def total_price
    total = total_items_price
    total += self.fee
    total += self.delivery_fee
  end

  private

    #
    # 手数料を計算する
    #
    def calc_fee(cart)
      total = cart.cart_items.to_a.sum(&:subtotal)
      if total < 10_000
        FEE_0_to_10_000
      elsif total < 30_000
        FEE_10_000_to_30_000
      elsif total < 100_000
        FEE_30_000_to_100_000
      else
        FEE_OVER_100_000
      end
    end

    #
    # 送料を計算する
    #
    def calc_delivery_fee(cart)
      items_quantity = cart.cart_items.to_a.sum(&:quantity)
      DELIVERY_FEE * (items_quantity / DELIVERY_FEE_PER_QUANTITY).to_i
    end

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
    # 注文日を設定する。
    #
    def set_order_date
      self.date = DateTime.now
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

    #
    # 利用するポイント数が利用可能かどうか検証する。
    #
    def validate_available_use_point
      return if self.use_point.nil?

      if self.use_point > self.user.point
        errors.add(:use_point, :use_point_not_available)
      end
    end

    #
    # 注文商品を確定する。
    #
    def decide_order_items!
      self.order_items.each do |order_item|
        order_item.item.remove_stock!(order_item.quantity)
      end
    rescue ActiveRecord::RecordInvalid => invalid
      invalid.record.errors.full_messages.each do |error|
        self.errors.add(:order_items, I18n.t('errors.nested_format', { model: invalid.record.to_s, message: error }))
      end
      raise invalid
    end
end
