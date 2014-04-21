#
# カート商品。
#
class CartItemsController < ApplicationController
  before_action :set_item, only: [:add, :create] 
  before_action :set_cart_item, only: [:add, :update, :destroy]

  # GET /cart_items
  # GET /cart_items.json
  def index
    @cart_items = current_cart.cart_items
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
  end
  
  def add
  end

  # POST /cart_items
  # POST /cart_items.json
  def create
    @cart_item = current_cart.cart_items.build(cart_item_params)
    @cart_item.item = @item

    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to cart_items_path, notice: I18n.t('helpers.notice.success.create', { model: CartItem.model_name.human }) }
        format.json { render action: 'show', status: :created, location: @cart_item }
      else
        format.html { render action: 'add' }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update
    respond_to do |format|
      if @cart_item.update(cart_item_params)
        format.html { redirect_to cart_items_path, notice: I18n.t('helpers.notice.success.update', { model: CartItem.model_name.human }) }
        format.json { head :no_content }
      else
        format.html { render action: 'add' }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = current_cart.cart_items.search_item(params[:item_id]).first_or_initialize
    end

    def set_item
      @item = Item.find(params[:item_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_item_params
      params.require(:cart_item).permit(:quantity)
    end
end
