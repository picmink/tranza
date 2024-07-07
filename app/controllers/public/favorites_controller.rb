class Public::FavoritesController < ApplicationController
    before_action :authenticate_user!
    before_action :guest_check, only: [:create, :destroy]
    before_action :is_matching_login_user, only: [:destroy, :create]

    def is_matching_login_user
        @user = User.find(params[:id])
          unless @user.id == current_user.id
            redirect_to posts_path
          end
    end 
    
    def create
        @post = Post.find(params[:post_id])
        @favorite = @post.favorites.new(user_id: current_user.id)
        if @favorite.save
            redirect_to request.referer
        else
            redirect_to request.referer
        end 
    end 
    
    def destroy
        @post = Post.find(params[:post_id])
        @favorite = @post.favorites.find_by(user_id: current_user.id)
        if @favorite.present?
            @favorite.destroy
            redirect_to request.referer
        else 
            redirect_to request.referer
        end 
    end 
    
    def show
        @user = User.find(params[:id])
        @favorites = @user.favorites
        if @favorites.empty?
            redirect_to favorites_empty_path
        end 
    end 
    
    def empty
    end 
    
    def guest_check
        if current_user && current_user.email  == 'guest@example.com'
          redirect_to posts_path, notice: "この機能を利用するには会員登録が必要です。"
        end
    end
    
    
    private
    def set_user
        @user = User.find(params[:user_id])
    end 
end
