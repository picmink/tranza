class Public::CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :guest_check
    #before_action :is_matching_login_user, only: [:destroy]

    def is_matching_login_user
        @user = User.find(params[:id])
          unless @user.id == current_user.id
            redirect_to posts_path
          end
    end 
    
    def guest_check
        if current_user && current_user.email  == 'guest@example.com'
          redirect_to posts_path, notice: "この機能を利用するには会員登録が必要です。"
        end
    end
    
    def create
        post_comment = Post.find(params[:post_id])
        comment = current_user.comments.new(comment_params)
        comment.post_id = post_comment.id
        comment.save
        redirect_to post_path(post_comment)
    end 
    
    def destroy
        @comment = Comment.find(params[:id])
        if @comment.user.id == current_user.id
            @comment.destroy
            redirect_to post_path(params[:post_id]), notice: "コメントを削除しました。"
        else
            render :show
        end 
    end 
    
    private
    
    def comment_params
        params.require(:comment).permit(:comment, :user_id, :post_id)
    end 
    
    
end
