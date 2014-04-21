#
# クーポン
#
class Coupon < ActiveRecord::Base
  belongs_to :user
  has_one :coupon_log, dependent: :destroy

  validates :code, :point, presence: true
  validates :code, uniqueness: true
  validates :code, format: { with: /[0-9a-zA-Z]{12,}/ }
  validates_numericality_of :point, greater_than: 0

  scope :by_newest, -> { order(code: :asc) }
  default_scope by_newest

  #
  # クーポンを利用済みにする。
  #
  def used!(user)
    return unless self.available?

    coupon_log = self.build_coupon_log
    coupon_log.user = user
    coupon_log.save!
  end

  #
  # 利用可能かどうか
  #
  def available?
    self.coupon_log.nil?
  end
end
