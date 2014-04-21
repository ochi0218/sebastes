#
# 商品
#
class Item < ActiveRecord::Base
  has_many :cart_items
  has_many :order_items

  validates :name, :price, :sort_no, presence: true
  validates :image, file_size: { maximum: 0.5.megabytes.to_i }
  validates_numericality_of :price, :sort_no, greater_than: 0
  validates_numericality_of :stock, greater_than_or_equal_to: 0, message: :negative_number_of_item_stock

  scope :published, -> { where(display_flag: true) }
  scope :by_publish_sort, -> { order(sort_no: :asc) }
  scope :by_newest, -> { order(updated_at: :desc) }
  default_scope by_newest

  mount_uploader :image, ItemImageUploader

  #
  # ロックをかけて更新を行う。
  #
  def update_with_lock(item_attributes)
    self.with_lock do
      self.update(item_attributes)
    end
  end

  #
  # 在庫を追加する。
  #
  def add_stock(add_stock_num)
    self.with_lock do
      add_stock = (add_stock_num.present? ? add_stock_num : 0)
      self.stock += add_stock.to_i
      self.save
    end
  end

  #
  # 在庫を減らす。
  #
  def remove_stock!(remove_stock_num)
    self.with_lock do
      remove_stock = (remove_stock_num.present? ? remove_stock_num : 0)
      self.stock -= remove_stock.to_i
      self.save!
    end
  end

  #
  # 指定の個数より多いか確認する。
  #
  def confirm_stock_of(quantity)
    self.with_lock do
      self.stock >= quantity
    end
  end
  
  def to_s
    self.name
  end
end
