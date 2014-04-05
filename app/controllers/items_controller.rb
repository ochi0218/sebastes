#
# 商品コントローラ。
#
class ItemsController < ApplicationController
  #
  # 初期画面.
  #
  def index
    @items = Item.published.by_publish_sort.page
  end
end
