#
# ユーザ
#
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_point_logs
  has_many :coupon_logs

  mount_uploader :profile_image, UserProfileImageUploader

  before_validation :blank_password_to_nil
  validates :destination_zip_code, format: { with: /\d{3,}-\d{4,}/ }, allow_blank: true
  validates :profile_image, file_size: { maximum: 0.5.megabytes.to_i }

  #
  # ポイントを更新する。
  #
  def update_user_point(user_point_log)
    User.transaction do
      self.lock!

      user_point_log.user = self if user_point_log.user.nil?
      user_point_log.log_date = DateTime.now if user_point_log.log_date.nil?
      user_point_log.kind = :system if user_point_log.kind.nil?
      user_point_log.before_point = self.point

      return false unless user_point_log.save

      new_point = self.point + user_point_log.change_point
      self.update_attribute(:point, new_point)
    end
  end

  private

  #
  # 空白のパスワードをnilにする
  #
  def blank_password_to_nil
    self.password = nil if self.password.blank?
    self.password_confirmation = nil if self.password_confirmation.blank?
  end
end

