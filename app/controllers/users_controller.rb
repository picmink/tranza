class UsersController < ApplicationController
    def index
    end
    
    def edit
        @user = User.find(params[:id])
        if @user.save
        end 
    end 
    
    def show
        @user = User.find(params[:id])
        @posts = Post.all
    end 
    
    def create
        @post = Post.new(post_params)
        @post.user_id= current_user.id
        @post.save
        
    end 
    
    def update
        @user = User.find(params[:id])
    end 
    
    def destroy
        @user = User.find(params[:id])
    end 
    
    
    private
    def users_params
        params.require(:user).permit(:name, :image)
    end 
end 