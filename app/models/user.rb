#
# ユーザ
#
class User < ActiveRecord::Base
  has_many :user_point_logs
  has_many :coupon_logs
  has_many :diaries
  has_many :comments
  has_many :orders

  validates :destination_zip_code, format: { with: /\d{3,}-\d{4,}/ }, allow_blank: true
  validates :profile_image, file_size: { maximum: 0.5.megabytes.to_i }
  validates_numericality_of :point, greater_than_or_equal_to: 0, message: :negative_number_of_change_point

  scope :by_newest, -> { order(updated_at: :desc) }
  default_scope by_newest

  acts_as_voter
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :profile_image, UserProfileImageUploader

  before_validation :blank_password_to_nil

  #
  # クーポンを利用する。
  #
  def use_coupon(coupon)
    return if coupon.nil?

    self.with_lock do
      return if coupon.available?

      user_point_log = self.user_point_logs.build({ kind: :coupon, change_point: coupon.point })
      user_point_log.save!

      self.point += coupon.point
      self.save!

      coupon.used!(self)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  #
  # カートの商品を購入する。
  #
  def purchase(order, cart)
    self.with_lock do
      order.decided!
      cart.destroy

      self.use_point(order.use_point) if order.use_point.present?
      true
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  #
  # システムからのポイントを付与する。
  #
  def add_point_by_system(user_point_log)
    self.with_lock do
      return true if user_point_log.change_point == 0

      user_point_log.kind = :system
      user_point_log.save!

      add_point_num = user_point_log.change_point.present? ? user_point_log.change_point : 0
      self.point += add_point_num.to_i
      self.save!
    end
  rescue
    false
  end

  #
  # ロックをかけて更新を行う。
  #
  def update_with_lock(user_attributes)
    self.with_lock do
      self.update(user_attributes)
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
    # ポイントを利用する。
    #
    def use_point(point)
      return if point.nil? or point == 0

      user_point_log = self.user_point_logs.build({ kind: :used, change_point: -point })
      user_point_log.save!

      self.point -= point
      self.save!
    end
end

