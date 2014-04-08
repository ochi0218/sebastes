#
# 商品
#
class Item < ActiveRecord::Base
  attr_accessor :add_stock_num

  validates :name, :price, :sort_no, presence: true
  validates :image, file_size: { maximum: 0.5.megabytes.to_i }
  validates_numericality_of :price, :sort_no, greater_than: 0
  validates_numericality_of :stock, greater_than_or_equal_to: 0
  validates_numericality_of :add_stock_num, greater_than: 0, allow_nil: true

  mount_uploader :image, ItemImageUploader

  scope :published, -> { where(display_flag: true) }
  scope :by_publish_sort, -> { order(sort_no: :asc) }
  scope :by_newest, -> { order(updated_at: :desc) }
  default_scope by_newest

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
  def add_stock(item_attributes)
    self.with_lock do
      self.add_stock_num = item_attributes[:add_stock_num]
      add_stock = (self.add_stock_num.present? ? self.add_stock_num : 0)
      self.stock += add_stock.to_i
      self.update({ stock: self.stock })
    end
  end
end
