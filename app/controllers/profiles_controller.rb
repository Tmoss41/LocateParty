class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_profile, only: [:edit, :update]
    def show
        @user = User.find(params[:id])
        @characters = @user.characters.pluck(:id, :name, :race)
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
                @location = Location.new(suburb: params[:profile][:location][:suburb], state: params[:profile][:location][:state], post_code: params[:profile][:location][:post_code], profile_id: @profile.id)
            if @location.save
                redirect_to current_user
            else
                flash.alert = @location.errors.full_messages
                redirect_to new_profile_path
            end
        else
            flash.alert = @profile.errors.full_messages
            redirect_to new_profile_path
        end 
    end
    def edit
    end
    def update
        authorize @profile
        if @profile.update(profile_params)
            @location = @profile.location
            if @location.update(suburb: params[:profile][:location][:suburb], state: params[:profile][:location][:state], post_code: params[:profile][:location][:post_code], profile_id: @profile.id)
                redirect_to current_user
            else
                flash.alert = @location.errors.full_messages
                redirect_to edit_profile_path(@profile)
            end
        else
            @profile.destroy
            @location.destroy
            flash.alert = @profile.errors.full_messages
            redirect_to edit_profile_path(@profile)
        end
    end
    def find
        if params[:post_code].length == 4
            @location = Location.where("suburb like ? AND state like ? AND post_code = ?", "%#{params[:suburb]}%", "%#{params[:state]}%", "#{params[:post_code]}")
        else
            flash.notice = "Invalid Postcode"
            redirect_to current_user
        end 
    end
    private
    def profile_params
        params.require(:profile).permit(:first_name, :last_name, :bio, :user_id, :mobile, :suburb, :avatar)
    end
    def set_profile
        @profile = Profile.find(params[:id])
    end
end
