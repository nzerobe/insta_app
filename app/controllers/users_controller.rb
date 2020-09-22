class UsersController < ApplicationController
  before_action :require_logged_in, only: [:index, :show]

  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to blogs_path, notice: "権限がありません。"
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: "編集しました。"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end

  def require_logged_in
    unless logged_in?
      redirect_to new_session_path, notice: "ログインしてください。"
    end
  end

end
