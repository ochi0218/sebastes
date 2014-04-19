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

  scope :by_newest, -> { order(updated_at: :desc) }
  default_scope by_newest

  acts_as_voter
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :profile_image, UserProfileImageUploader

  before_validation :blank_password_to_nil

  #
  # ポイントを更新する。
  #
  def update_user_point(user_point_log)
    self.with_lock do 
      update_point(user_point_log) if create_user_point_log(user_point_log)
    end
  end

  #
  # ロックをかけて更新を行う。
  #
  def update_with_lock(user_attributes)
    self.with_lock do
      self.update(user_attributes)
    end
  end

  #
  # 配送先情報を付加して注文を新規作成する。
  #
  def new_order_with_destination_info
    Order.new.tap{|order|
      order.destination_zip_code = self.destination_zip_code
      order.destination_address = self.destination_address
      order.destination_name = self.destination_name
    }
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
  # ユーザポイント履歴からポイントを更新する。
  #
  def update_point(user_point_log)
    new_point = self.point + user_point_log.change_point
    self.update_attribute(:point, new_point)
  end

  #
  # 新たにユーザポイント履歴を作成する。
  #
  def create_user_point_log(user_point_log)
    user_point_log.log_date = DateTime.now
    user_point_log.kind = :system if user_point_log.kind.nil?
    user_point_log.before_point = self.point

    user_point_log.save
  end
end

