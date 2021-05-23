class ApplicationController < ActionController::Base
    include Pundit
    helper_method [:current_group]
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    private
    def user_not_authorized
        flash[:alert] = 'You are not authorized to perform this action'
        redirect_to current_user
    end
end
