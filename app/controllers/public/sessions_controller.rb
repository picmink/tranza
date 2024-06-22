# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
    before_action :configure_permitted_parameters, if: :devise_controller?

      def after_sign_in_path_for(resource)
        user_path(current_user.id)
      end
      
      def after_sign_up_path_for(resource)
        user_path(current_user.id)
      end
      
      def after_sign_out_path_for(resource)
        root_path
      end
      
      
      
      
      private
      
      def admin_controller?
      self.class.module_parent_name == 'Admins'
      end
  
  
      protected
    
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      end
    
    def reject_user
        @user = User.find_by(name: params[:user][:name])
        if @user
            if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
                flash[:notece] = "退会済みです。再度会員登録をしてご利用ください。"
                redirect_to new_user_registration_path
            else
                flash[:notice] = "項目を入力してください"
            end
        end
    end 
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
