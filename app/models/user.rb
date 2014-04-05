#
# ユーザ
#
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :coupon_logs

  mount_uploader :profile_image, UserProfileImageUploader

  before_validation :blank_password_to_nil
  validates :destination_zip_code, format: { with: /\d{3,}-\d{4,}/ }, allow_blank: true
  validates :profile_image, file_size: { maximum: 0.5.megabytes.to_i }

  private

  #
  # 空白のパスワードをnilにする
  #
  def blank_password_to_nil
    self.password = nil if self.password.blank?
    self.password_confirmation = nil if self.password_confirmation.blank?
  end
end

