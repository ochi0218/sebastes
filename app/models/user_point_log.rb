#
# ユーザポイント履歴。
#
class UserPointLog < ActiveRecord::Base
  belongs_to :user

  validates :change_point, :kind, presence: true

  scope :by_newest, -> { order(updated_at: :desc) }
  scope :by_log_date, -> { order(log_date: :desc) }
  default_scope by_newest

  extend Enumerize
  enumerize :kind, in: { system: 1, coupon: 2, used: 3 }

  before_create :set_log_date, :set_before_point

  private

  #
  # 前回ポイントを設定する。
  #
  def set_before_point
    self.before_point = self.user.point
  end

  #
  # ログ日付を設定する。
  #
  def set_log_date
    self.log_date = DateTime.now
  end
end
