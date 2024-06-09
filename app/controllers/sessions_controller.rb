class SessionsController < ApplicationController
    protected
    
    def reject_user
        @user = User.find_by(name: params[:user][:name])
        if @user
            if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
                flash[:notece] = "退会済みです。再度会員登録をしてご利用ください。"
                redirect_to root_path
            else
                flash[:notice] = "項目を入力してください"
            end
        end
    end 
    
    
end
