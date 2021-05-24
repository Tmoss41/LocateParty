class ProfilesController < ApplicationController
    def show
        @user = User.find(params[:id])
        @characters = @user.characters.pluck(:id, :name)
        @approved_groups = @user.approved_groups
        @un_approved_groups = @user.un_approved_groups
        @groups = UserGroup.where(user_id: current_user.id)
        @profile = @user.profile
        @owner = current_user.id == @user.id
        @pending = @user.join_pending_groups.pluck(:name)
        @invites = @user.invite_pending_groups.pluck(:name, :id)
    end
    # def find_group
    #     @users = Group.where("name LIKE ? AND suburb like ? AND state like ?", "%#{params[:name]}%", "%#{params[:suburb]}%", "%#{params[:state]}%")
    # end
    def new
        @profile = Profile.new
    end
    def create
        @profile = Profile.new(profile_params)
        if @profile.save
            @location = Location.create!(suburb: params[:profile][:location][:suburb], state: params[:profile][:location][:state], post_code: params[:profile][:location][:post_code], profile_id: @profile.id)
            redirect_to current_user
        else
            flash.alert = "Error with profile creation, please try again"
            redirect_to new_profile_path
        end 
    end
    def edit
    @profile = Profile.find(params[:id])
    end
    def update
        @profile = Profile.find(params[:id])
        if @profile.update(profile_params)
            @location = Location.update(suburb: params[:profile][:location][:suburb], state: params[:profile][:location][:state], post_code: params[:profile][:location][:post_code], profile_id: @profile.id)
            redirect_to current_user
        else
            flash.alert = @profile.errors.full_messages
            redirect_to edit_profile_path(@profile)
        end
    end
    def find
        @location = Location.where("suburb like ? AND state like ? AND post_code = ?", "%#{params[:suburb]}%", "%#{params[:state]}%", "#{params[:post_code]}")
    end
    private
    def profile_params
        params.require(:profile).permit(:first_name, :last_name, :bio, :user_id, :mobile, :suburb, :avatar)
    end
    def location_params
        params.require(:profile).require(:location).permit(:suburb, :post_code, :state)
    end
end
