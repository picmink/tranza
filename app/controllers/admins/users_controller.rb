class Admins::UsersController < ApplicationController
     before_action :authenticate_admin!
    def destroy
        user = User.find(params[:id])
        user.destroy
        redirect_to admins_dashboards_path, notice: 'ユーザーを削除しました。'
    end
end
