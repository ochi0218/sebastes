class ProvideUser < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  validates :provider_name, presence: true
end
