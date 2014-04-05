#
# ユーザ
#
class User < ActiveRecord::Base
  has_many :user_point_logs
  has_many :coupon_logs

  validates :destination_zip_code, format: { with: /\d{3,}-\d{4,}/ }, allow_blank: true
  validates :profile_image, file_size: { maximum: 0.5.megabytes.to_i }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :profile_image, UserProfileImageUploader

  before_validation :blank_password_to_nil

  scope :by_newest, -> { order(updated_at: :desc) }
  default_scope by_newest

  #
  # ポイントを更新する。
  #
  def update_user_point(user_point_log)
    User.transaction do
      self.lock!
      update_point(user_point_log) if create_user_point_log(user_point_log)
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

  #
  # 新たにユーザポイント履歴を作成する。
  #
  def create_user_point_log(user_point_log)
    user_point_log.user = self if user_point_log.user.nil?
    user_point_log.log_date = DateTime.now if user_point_log.log_date.nil?
    user_point_log.kind = :system if user_point_log.kind.nil?
    user_point_log.before_point = self.point

    user_point_log.save
  end

  #
  # ユーザポイント履歴からポイントを更新する。
  #
  def update_point(user_point_log)
    new_point = self.point + user_point_log.change_point
    self.update_attribute(:point, new_point)
  end
end

