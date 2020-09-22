class BlogsController < ApplicationController

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    @user = @blog.user
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def new
    @blog = Blog.new
  end
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to blogs_path, notice: "ブログを作成しました！"
    else
      render :new
    end
  end
  def confirm
    @blog = Blog.new(blog_params)
  end

  def edit
    @blog = Blog.find(params[:id])
    if @blog.user != current_user
      redirect_to blogs_path, notice: "権限がありません。"
    end
  end
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "編集しました。"
    else
      render :edit
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "削除しました。"
  end

  private
  def blog_params
    params.require(:blog).permit(:image, :content, :image_cache)
  end
end
