#
# クーポン
#
class Coupon < ActiveRecord::Base
  belongs_to :user
  validates :code, :point, presence: true
  validates :code, uniqueness: true
  validates :code, format: { with: /[0-9a-zA-Z]{4,}-[0-9a-zA-Z]{4,}-[0-9a-zA-Z]{4,}-[0-9a-zA-Z]{4,}/ }
  validates_numericality_of :point, greater_than: 0
end
