class ProfilesController < ApplicationController
    before_action :authenticate_user! # Confirms that the user is signed in before each action 
    before_action :set_profile, only: [:edit, :update] # Runs method set_profile before edit and update actions
    
    def show # Generates the profile page
        # Creates variables that query the correct databases to get the information needed to render the page 
        @user = User.find(params[:id]) # Finds the user the page is for
        @characters = @user.characters.pluck(:id, :name, :race) # Grabs all of the users characters, and saves only their name, race and id
        @approved_groups = @user.approved_groups # GRabs all of the users approved groups
        @un_approved_groups = @user.un_approved_groups # GRabs all of the users un-approved groups
        @profile = @user.profile # GRabs the user's profile
        @owner = current_user.id == @user.id
        @pending = @user.join_pending_groups.pluck(:name) # Grabs all of the users pending_groups and grabs the name column
        @invites = @user.invite_pending_groups.pluck(:name, :id) # Grabs all of the users pending_groups and grabs the name column and id column
    end
    def new
        @profile = Profile.new # Creates a new variable to be used as a model on the form rendered on the new page
    end
    def create # Accepts the post request from the new page
        @profile = Profile.new(profile_params) #$ Creates a new instance of Profile and gives it the parameters permitted in the profile_params method
        if @profile.save # Attempts to save the profile
                # IF succesful, variable @location is created and assigned a new instance of Location Model with the params permitted in location_params method
                @location = Location.new(location_params(@profile.id))
            if @location.save # Attempts to save the location
                redirect_to current_user # If succesful, takes the user to their profile page
            else
                # If the location fails then generates a flash alert and reloads the new profile form, and also destroys the existing profile instance in the datbase
                @profile.destroy
                flash.alert = @location.errors.full_messages
                redirect_to new_profile_path
            end
        else 
            # If the profile save fails, then generates flash alert and renders the new form again
            flash.alert = @profile.errors.full_messages
            redirect_to new_profile_path
        end 
    end
    def edit
    end
    def update
        authorize @profile # Checks that the user is the owner of the profile
        if @profile.update(profile_params) # Attempts to update profile with new params 
            # If succesful, then tries to update location with new params
            @location = @profile.location 
            if @location.update(location_params(@profile.id)) # If location update is sucesful, then returns the user to their profile page
                redirect_to current_user
            else
                # IF location update fails, then  renders flash message and takes user back profile edit page
                flash.alert = @location.errors.full_messages
                redirect_to edit_profile_path(@profile)
            end
        else
             # IF profile update fails, then  renders flash message and takes user back profile edit page
            flash.alert = @profile.errors.full_messages
            redirect_to edit_profile_path(@profile)
        end
    end
    def find
        # Confirms that a parameter is considered valid
        if params[:post_code].length == 4
            # Finds all of the locations where the parameters match the ones passed in the form
            @location = Location.where("suburb like ? AND state like ? AND post_code = ?", "%#{params[:suburb]}%", "%#{params[:state]}%", "#{params[:post_code]}")
        else
            # Fails if the post_code does not pass the valid check
            flash.notice = "Invalid Postcode"
            redirect_to current_user
        end 
    end
    private
    def profile_params
        # Sets the allowed params for profile
        params.require(:profile).permit(:first_name, :last_name, :bio, :user_id, :mobile, :suburb, :avatar)
    end
    def set_profile
        # Sets the @profile variable
        @profile = Profile.find(params[:id])
    end
    def location_params(profile)
        # Sets the allowed paramns for location
        params[:profile][:location][:group_id] = profile
        params.require(:profile).require(:location).permit(:suburb, :state, :post_code, :profile_id)
    end
end
