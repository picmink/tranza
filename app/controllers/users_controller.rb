class UsersController < ApplicationController
    def index
        @search = User.ransack(params[:q])
        @users = @search.result.page(params[:page]).per(10).order("created_at desc")
    end
    
    def edit
        @user = User.find(params[:id])
        if @user.save
        end 
    end 
    
    def show
        @user = User.find(params[:id])
        @posts = @user.posts
    end 
    
    def create
        @post = Post.new(post_params)
        if @post.user_id = current_user.id
           @post.save
           render post_path
        else
           render user_path(current_user.id)
        end 
        
        
    end 
    
    def withdrawal
    end 
    
    def update
        @user = User.find(params[:id])
        if @user.user.id = current_user.id
           @user = update(user_params)
           redirect_to user_path(@user)
        else
           render user_path(@user)
        end 
    end 
    
    def destroy
        @user = User.find(params[:id])
        if @user.user.id = current_user.id
           @user.destroy
           redirect_to root_path
        else
           render user_path(@user)
        end 
    end 
    
    
    private
    def users_params
        params.require(:user).permit(:name, :image)
    end 
end 