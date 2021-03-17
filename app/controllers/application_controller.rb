class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :set_current_user

	check_authorization :unless => :devise_controller?
	before_action :configure_permitted_parameters, if: :devise_controller?

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to "/", :alert => exception.message
	end

	layout :resolve_layout
	protected

	def resolve_layout
		if((controller_name == "sessions" && action_name == "new") || (controller_name == "unlocks") || (controller_name == "passwords" && (action_name == "new" || action_name == "edit" || action_name == "create")) || (controller_name == "registrations" && action_name == "new"))
	      "login"
	    else
	      "application"
	    end
	end

	def configure_permitted_parameters
	    #devise_parameter_sanitizer.for(:sign_up) << :username
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email])
	end

	def current_ability
		@current_ability ||= Ability.new(current_user)
	end

	def set_current_user
		User.current = current_user
	end
end
