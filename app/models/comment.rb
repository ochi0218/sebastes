#
# コメント
#
class Comment < ActiveRecord::Base
  belongs_to :diary
  belongs_to :user

  validates :contents, presence: true
end
