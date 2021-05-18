class ProfilesController < ApplicationController
    def index
        @user = User.find(params[:id])
        @groups = UserGroup.where(user_id: current_user.id)
    end
    private
end
