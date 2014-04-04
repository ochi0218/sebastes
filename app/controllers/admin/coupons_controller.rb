#
# クーポンコントローラ
#
class Admin::CouponsController < Admin::ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin_user!

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = Coupon.page
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
  end

  # GET /coupons/new
  def new
    @coupon = Coupon.new
  end

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = Coupon.new(coupon_params)

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to [:admin, @coupon], notice: I18n.t('helpers.notice.success.create', { model: Coupon.model_name.human }) }
        format.json { render action: 'show', status: :created, location: @coupon }
      else
        format.html { render action: 'new' }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to [:admin, @coupon], notice: I18n.t('helpers.notice.success.update', { model: Coupon.model_name.human }) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    respond_to do |format|
      format.html {
        flash[:alert] = I18n.t('helpers.alert.model_conflict')
        redirect_to action: 'edit'
      }
      format.json { render json: @item.errors, status: :conflict }
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to admin_coupons_url, notice: I18n.t('helpers.notice.success.destroy', { model: Coupon.model_name.human }) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:code, :point, :lock_version)
    end
end
