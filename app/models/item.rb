#
# 商品
#
class Item < ActiveRecord::Base
  mount_uploader :item_image, ItemImageUploader

  validates :name, :price, :sort_no, presence: true
  validates :item_image, file_size: { maximum: 0.5.megabytes.to_i }
  validates_numericality_of :price, :sort_no , greater_than: 0
end
