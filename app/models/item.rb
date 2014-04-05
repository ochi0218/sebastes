#
# 商品
#
class Item < ActiveRecord::Base
  mount_uploader :image, ItemImageUploader

  validates :name, :price, :sort_no, presence: true
  validates :image, file_size: { maximum: 0.5.megabytes.to_i }
  validates_numericality_of :price, :sort_no, greater_than: 0
  validates_numericality_of :stock, greater_than_or_equal_to: 0
end
