class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if:  :devise_controller?
    protected
    def authenticate_admin!
        redirect_to root_path , notice: "no puede acceder" unless user_signed_in? && current_user.is_user_admin?
    end
    def authenticate_seller!
        redirect_to root_path unless user_signed_in? && current_user.is_user_editor?
     end
    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) << :name
        devise_parameter_sanitizer.for(:sign_up) << :last_name
    end
end
