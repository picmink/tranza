class Public::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_normal_user, only: :destroy
    before_action :guest_check, only: [:edit, :update, :create, :setting, :withdrawal]
    before_action :is_matching_login_user, only: [:edit, :update, :withdrawal, :destroy]

    def is_matching_login_user
        @user = User.find(params[:id])
          unless @user.id == current_user.id
            redirect_to posts_path
          end
    end 
    
    def ensure_normal_user
        if resource.email == 'guest@example.com'
          redirect_to posts_path, alert: 'ゲストユーザーは削除できません。'
        end
    end
    
    def guest_check
        if current_user && current_user.email == 'guest@example.com'
          redirect_to posts_path, notice: "この機能を利用するには会員登録が必要です。"
        end
    end 
    
    
    def index
        @search = User.ransack(params[:q])
        @users = @search.result.page(params[:page]).per(10).order("created_at desc")
    end
    
    def edit
        @user = User.find(params[:id])
        unless @user.id == current_user.id
            redirect_to user_path(@user) 
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
        @posts = @user.posts.page(params[:page]).per(5).order("created_at desc")
        @comments = Comment.where(post_id: params[:post_id]).page(params[:page]).per(5).order("created_at desc")
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
        @user = User.find(params[:id])
        @user.update(is_deleted: true)
        reset_session
        flash[:notice] = "退会処理を実行いたしました.またのご利用お待ちしております。"
        redirect_to root_path
    end 
    
    def unsubscribe
        @user = User.find(params[:id])
    end 
    
    def setting
        @user = User.find(params[:id])
        @posts = @user.posts
        @comments = @user.comments
    end 
    
    def users_posts
        @user = User.find(params[:id])
        @posts = @user.posts
    end 
    
    def users_comments
        @user = User.find(params[:id])
        @comments = @user.comments
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