class Public::CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :guest_check
    
    
    def guest_check
        if current_user && current_user.email  == 'guest@example.com'
          redirect_to posts_path, notice: "この機能を利用するには会員登録が必要です。"
        end
    end
    
    def create
        post = Post.find(params[:post_id])
        comment = current_user.comments.new(comment_params)
        comment.post_id = post.id
        comment.save
        redirect_to post_path(post)
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
        params.require(:comment).permit(:comment)
    end 
    
    
end
