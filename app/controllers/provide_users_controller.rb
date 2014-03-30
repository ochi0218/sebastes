class ProvideUsersController < ApplicationController
  before_action :set_provide_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin_user!

  # GET /provide_users
  # GET /provide_users.json
  def index
    @provide_users = ProvideUser.all
  end

  # GET /provide_users/1
  # GET /provide_users/1.json
  def show
  end

  # GET /provide_users/new
  def new
    @provide_user = ProvideUser.new
  end

  # GET /provide_users/1/edit
  def edit
  end

  # POST /provide_users
  # POST /provide_users.json
  def create
    @provide_user = ProvideUser.new(provide_user_params)

    respond_to do |format|
      if @provide_user.save
        format.html { redirect_to @provide_user, notice: 'Provide user was successfully created.' }
        format.json { render action: 'show', status: :created, location: @provide_user }
      else
        format.html { render action: 'new' }
        format.json { render json: @provide_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /provide_users/1
  # PATCH/PUT /provide_users/1.json
  def update
    respond_to do |format|
      if @provide_user.update(provide_user_params)
        format.html { redirect_to @provide_user, notice: 'Provide user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @provide_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /provide_users/1
  # DELETE /provide_users/1.json
  def destroy
    @provide_user.destroy
    respond_to do |format|
      format.html { redirect_to provide_users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provide_user
      @provide_user = ProvideUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provide_user_params
      params[:provide_user].permit(:email, :password, :password_confirmation, :provider_name)
    end
end
