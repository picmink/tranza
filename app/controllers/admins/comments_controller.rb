class Admins::CommentsController < ApplicationController
    before_action :authenticate_admin!
    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to admins_dashboards_path, notice: 'コメントを削除しました。'
    end
end
