#
# コメント
#
class Comment < ActiveRecord::Base
  belongs_to :diary
  belongs_to :user

  scope :by_newest, -> { order(updated_at: :desc) }
  default_scope { by_newest }

  validates :contents, presence: true
end
