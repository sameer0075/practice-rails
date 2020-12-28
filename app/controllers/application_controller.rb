class ApplicationController < ActionController::Base
	before_action :AddNameToUsers , if: :devise_controller? 

	def AddNameToUsers
		devise_parameter_sanitizer.permit(:sign_up,keys:[:name])
		devise_parameter_sanitizer.permit(:account_update,keys:[:name])
	end
end
