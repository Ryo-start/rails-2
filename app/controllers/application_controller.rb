class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])  # 新規登録時
        devise_parameter_sanitizer.permit(:account_update, keys: [:username])  # アカウント更新時
    end
end
