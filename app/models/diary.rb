#
# 日記
#
class Diary < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, :contents, presence: true
  validates :image, file_size: { maximum: 0.5.megabytes.to_i }

  scope :by_newest, -> { order(updated_at: :desc) }
  default_scope by_newest

  acts_as_votable
  mount_uploader :image, DiaryImageUploader
end
