class PostsController < ApplicationController
  before_action :guest_check, only: [:new, :edit, :create, :update, :destroy]
  
  def guest_check
        if current_user && current_user.email  == 'guest@example.com'
          redirect_to posts_path, notice: "この機能を利用するには会員登録が必要です。"
        end
  end
  
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
    @comment = Comment.new
  end

  def edit
    @posts = Post.find(params[:id])
    @tags = @posts.tags.pluck(:tag_name).join(" ")
  end

  def create
    @posts = Post.new(post_params)
    @posts.user_id = current_user.id
    tags = params[:post][:tag].split()
    if @posts.save
      @posts.save_tag(tags)
      redirect_to post_path(@posts)
    else
      render :new
    end
  end

  def update
    posts = Post.find(params[:id])
    tags = params[:post][:tag_ids].split(',')
    if posts.update(post_params)
      posts.update_tags(tags)
      redirect_to post_path(posts.id)
    else
      render :edit
    end 
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
