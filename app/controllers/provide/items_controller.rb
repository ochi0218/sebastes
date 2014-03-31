#
# 商品コントローラ。
#
class Provide::ItemsController < Provide::ApplicationController
  before_action :set_item, only: [:show, :edit, :update]
  before_action :authenticate_provide_user!

  def index
    @items = Item.page
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to [:provide, @item], notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :image, :price, :description, :display_flag, :sort_no)
    end
end
