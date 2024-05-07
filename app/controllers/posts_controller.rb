class PostsController < ApplicationController
  def new
    @posts = Post.new
  end

  def index
    @search = Post.ransack(params[:q])
    @posts = @search.result.page(params[:page]).per(10).order("created_at desc")
    @tags = Tag.all
  end

  def show
    @posts = Post.find(params[:id])
    @user = @posts.user
  end

  def edit
    @posts = Post.find(params[:id])
  end

  def create
    @posts = Post.new(post_params)
    @posts.user_id = current_user.id
    tags = params[:post][:tag].split()
    if @posts.save
      @posts.save_tag(tags)
      redirect_to post_path(@posts)
    else
      render:new
    end
  end

  def update
    @posts = Post.find(params[:id])
    
    
  end

  def destroy
    posts = Post.find(params[:id])
    posts.destroy
    redirect_to user_path(current_user)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:stone_name, :image, :caption)
  end 
  
 
end
