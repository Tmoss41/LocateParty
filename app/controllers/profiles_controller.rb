class ProfilesController < ApplicationController
    def index
        @user = User.find(params[:id])
        @groups = UserGroup.where(user_id: current_user.id)
<<<<<<< Updated upstream
=======
        @usergroup = UserGroup.all
        
>>>>>>> Stashed changes
    end
end
