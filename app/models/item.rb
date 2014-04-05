#
# 商品
#
class Item < ActiveRecord::Base
  validates :name, :price, :sort_no, presence: true
  validates :image, file_size: { maximum: 0.5.megabytes.to_i }
  validates_numericality_of :price, :sort_no, greater_than: 0
  validates_numericality_of :stock, greater_than_or_equal_to: 0

  mount_uploader :image, ItemImageUploader

  scope :published, -> { where(display_flag: true) }
  scope :by_publish_sort, -> { order(sort_no: :asc) }
  scope :by_newest, -> { order(updated_at: :desc) }
  default_scope by_newest
end
