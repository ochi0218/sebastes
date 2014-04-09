#
# 日記
#
class Diary < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, :contents, presence: true
  validates :image, file_size: { maximum: 0.5.megabytes.to_i }

  mount_uploader :image, DiaryImageUploader
end
