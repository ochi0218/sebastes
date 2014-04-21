#
# クーポン利用履歴
#
class CouponLog < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :user

  validates :coupon_id, uniqueness: true

  before_create :set_used_datetime

  private

    #
    # 利用日時を設定する。
    #
    def set_used_datetime
      self.used_datetime = DateTime.now
    end
end
