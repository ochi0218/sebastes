#
# 商品コントローラ。
#
class ItemsController < ApplicationController
  def index
    @items = Item.published.by_publish_sort.page
  end
end
