class HomesController < ApplicationController
    def top
    end 
    
    def about
    end 
    
    def guest_sign_in
        user = User.guest
        sign_in user
        redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
    end 
end
