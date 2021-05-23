class ApplicationController < ActionController::Base
    include Pundit
    helper_method [:current_group]
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    private
    def user_not_authorized
        if current_user != nil
            flash[:alert] = 'You are not authorized to perform this action'
            redirect_to current_user
        else 
            flash[:alert] = "You must be signed in to perform this action"
            redirect_to root_path
        end
    end
end
