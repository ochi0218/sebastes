#
# コメント
#
class Comment < ActiveRecord::Base
  belongs_to :diary
  belongs_to :user

  validates :contents, presence: true

  scope :by_newest, -> { order(updated_at: :desc) }
  default_scope { by_newest }
end
