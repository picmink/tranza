class UsersController < ApplicationController
    def index
        @search = User.ransack(params[:q])
        @users = @search.result.page(params[:page]).per(10).order("created_at desc")
    end
    
    def edit
        user = User.find(params[:id])
        unless user.id == current_user.id
            redirect_to user_path(user) 
        end 
        @user = User.find(params[:id])
    end 
    
    def update
        user = User.find(params[:id])
        unless user.id == current_user.id
            render setting_path(current_user.id)
        end 
        if user.id = current_user.id
           user.update(user_params)
           redirect_to user_path(user)
        else
           render setting_path(current_user.id)
        end 
    end 
    
    def show
        @user = User.find(params[:id])
        @posts = @user.posts
    end 
    
    def create
        @post = Post.new(post_params)
        user = User.find(params[:id])
        unless user.id == current_user.id
            render user_path(current_user.id)
        end 
        if @post.user_id = current_user.id
           @post.save
           render post_path
        else
           render user_path(current_user.id)
        end 
        
        
    end 
    
    def withdrawal
    end 
    
    def setting
        @user = User.find(params[:id])
    end 
    
    def destroy
        @user = User.find(params[:id])
        unless @user.id == current_user.id
            render user_path(@user)
        end 
        if @user.user.id = current_user.id
           @user.destroy
           redirect_to root_path
        else
           render user_path(@user)
        end 
    end 
    
    
    private
    def user_params
        params.require(:user).permit(:name, :profile_image)
    end 
end 