class PostsController < ApplicationController
  def new
    @posts = Post.new
  end

  def index
    @posts = Post.find(params[:id])
  end

  def show
    @posts = Post.find(params[:id])
  end

  def edit
    @posts = Post.find(params[:id])
  end

  def create
    @posts = Post.new(post_params)
    @posts.user_id = current_user.id
    @posts.save
    redirect_to user_path
  end

  def update
    @posts = Post.find(params[:id])
    
  end

  def destroy
    posts = Post.find(params[:id])
    posts.destroy
  end
  
  private
  
  def post_params
    params.require(:post).permit(:stone_name, :image, :caption)
  end 
end
