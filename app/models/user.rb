#
# ユーザ
#
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :coupon_logs

  validates :destination_zip_code, format: { with: /\d{3,}-\d{4,}/ }, allow_blank: true
end
