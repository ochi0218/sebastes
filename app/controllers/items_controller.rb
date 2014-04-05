#
# 商品コントローラ。
#
class ItemsController < ApplicationController
  #
  # 初期画面.
  #
  def index
    @items = Item.published.publish_sorted.page
  end
end
