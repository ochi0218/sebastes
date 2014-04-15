#
# ユーザポイント履歴。
#
class UserPointLog < ActiveRecord::Base
  belongs_to :user

  validates :change_point, :kind, :before_point, presence: true
  validates_numericality_of :change_point, allow_nil: true
  validates_numericality_of :before_point, greater_than_or_equal_to: 0

  scope :by_newest, -> { order(updated_at: :desc) }
  scope :by_log_date, -> { order(log_date: :desc) }
  default_scope by_newest

  extend Enumerize
  enumerize :kind, in: { system: 1, coupon: 2, used: 3 }

  before_save :validate_negative_number_of_changed_point

  private

  #
  # 変動後のポイントが負の値にならないか検証する。
  #
  def validate_negative_number_of_changed_point
    if self.before_point + self.change_point < 0
      errors.add(:change_point, I18n.t('errors.messages.negative_number_of_change_point'))
      false
    end
  end
end
