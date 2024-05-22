class HomesController < ApplicationController
    def top
    end 
    
    def about
    end 
    
    def guest_sign_in
        user = User.find_or_create_by!(email: 'guest@example.com') do |user|
            user.password = SecureRandom.urlsafe_base64
        end 
        if sign_in user
            flash[:notice] = "ゲストユーザーとしてログインしました。"
            redirect_to posts_path
        end 
    end 
end
