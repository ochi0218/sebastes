#
# クーポンコントローラ。
#
class CouponsController < ApplicationController
  before_action :set_coupon, only: [:update]
  before_action :authenticate_user!

  def find
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    respond_to do |format|
      if @coupon.nil?
        format.html { 
            flash.now[:alert] = 'Not Foound'
            render action: 'find'
        }
        format.json { render json: @coupon.errors, status: :not_found }
      else
        if @coupon.use_by(current_user)
          format.html { redirect_to root_path, notice: I18n.t('coupons.update.coupon_use_success') }
          format.json { head :no_content }
        else
          format.html { 
            flash.now[:alert] = I18n.t('coupons.update.coupon_not_available')
            render action: 'find'
          }
          format.json { render json: @coupon.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private 

  def set_coupon
    @coupon = Coupon.find(:first, conditions: coupon_params)
  end

  def coupon_params
    params.require(:coupon).permit(:code)
  end
end
