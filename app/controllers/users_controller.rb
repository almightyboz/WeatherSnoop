class UsersController < ApplicationController
  before_action :set_user, only: :show

  def index
    @users = User.all
  end

  def show
    @queries = @user.queries
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end
end
