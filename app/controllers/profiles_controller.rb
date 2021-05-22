class ProfilesController < ApplicationController
    def show
        @user = User.find(params[:id])
        @groups = UserGroup.where(user_id: current_user.id)
        @profile = @user.profile
        @owner = current_user.id == @user.id
    end
    # def find_group
    #     @users = Group.where("name LIKE ? AND suburb like ? AND state like ?", "%#{params[:name]}%", "%#{params[:suburb]}%", "%#{params[:state]}%")
    # end
    def new
        @profile = Profile.new
    end
    def create
        @profile = Profile.create(profile_params)
        redirect_to current_user
    end
    def edit
        @profile = Profile.find(params[:id])
    end
    def update
        @profile = Profile.find(params[:id])
        @profile.update(profile_params)
        redirect_to current_user
    end
    def find
        @profiles = Profile.where("first_name LIKE ? AND last_name like ? AND suburb like ?", "%#{params[:first_name]}%", "%#{params[:last_name]}%", "%#{params[:suburb]}%")
    end
    private
    def profile_params
        params.require(:profile).permit(:first_name, :last_name, :bio, :user_id, :mobile, :suburb)
    end
end
