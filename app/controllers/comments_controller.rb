class CommentsController < ApplicationController
    def create
        post = Post.find(params[:post_id])
        comment = current_user.comments.new(comment_params)
        comment.post_id = post.id
        comment.save
        redirect_to post_path(post)
    end 
    
    def destroy
        @user = User.find(params[:id])
        comment = Comment.find(params[:id])
        if @user.id == current_user.id
            comment.destroy
            redirect_to post_path(params[:post_id])
        else
            render :show
        end 
    end 
    
    private
    
    def comment_params
        params.require(:comment).permit(:comment)
    end 
    
    validates :comment, presence: true
end
