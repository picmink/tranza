class Admins::DashboardsController < ApplicationController
    layout 'admins'
    before_action :authenticate_admin!
    
    def index
        @users = User.all
        @comment = @user.comments(params[:comment_id])
    end
    
    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to admins_dashboards_path, notice: 'コメントを削除しました。'
    end
end
