#
# クーポン利用履歴
#
class CouponLog < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :user

  validates :used_datetime, presence: true
end
