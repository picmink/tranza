class FavoritesController < ApplicationController
    before_action :authenricate_user!
    
    def create
        @user = User.find(params[:user_id])
        favorite = @user.favorites.new(user_id: current_user.id)
        if favorite.save
            redirect_to request.referer
        else
            redirect_to request.referer
        end 
    end 
    
    def destroy
        @user = User.find(params[:user_id])
        favorite = @user.favorites.find_by(user_id: current_user.id)
        if favorite.present?
            favorite.destory
            redirect_to request.referer
        else 
            redirect_to request.referer
        end 
    end 
end
