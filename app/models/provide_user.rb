#
# 業務アカウント
#
class ProvideUser < ActiveRecord::Base
  validates :provider_name, presence: true

  scope :by_newest, -> { order(updated_at: :desc) }
  default_scope { by_newest }

  devise :database_authenticatable, :rememberable, :trackable, :validatable

  before_validation :blank_password_to_nil

  private

    #
    # 空白のパスワードをnilにする
    #
    def blank_password_to_nil
      self.password = nil if self.password.blank?
      self.password_confirmation = nil if self.password_confirmation.blank?
    end
end
