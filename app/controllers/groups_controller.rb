class GroupsController < ApplicationController
    before_action :authenticate_user! # Ensures that the user is signed in before any of the actions are run
    before_action :admin?, only: :show # Runs the admin? method on the show action
    before_action :set_group, only: [:edit, :show, :delete, :update, :attach_image] # Sets @group variable on the edit, show, delete, update and attach_image actions
    before_action :authorize_group, only: [:edit, :delete, :update] # Runs the method before each action after the @group variable is set
    def show
        @game = Game.new
        # Shows a specific group based on the id passed through from the webpage of the user
    end
    def make_admin
        # Method used on the Group Show page that allows an already existing admin to make another user admin
        @usergroup = UserGroup.where(user_id: params[:user_id], group_id: params[:group_id]).first  # Queries the database to grab the user_group entry that matches the user_id of the user 
         # that needs to be made admin, and group_id of the current groups (.first is used as their can only be one usergroup entry combination due to validation on the usergroup model, os only one exists)
        @usergroup.add_role :group_admin # Adds the role group_admin to the usergroup entry defined before
        redirect_to group_path(params[:group_id]) # Redirects the user back to the group page
    end
    def new
        # Saves a place in memory for a new  instance of a group and then redirects user to the new.html.erb page found in /views/groups
        @group = Group.new
    end
    def create
        # Accepts post request from web server and new page
        @group = Group.new(group_params) # Creates a new instance of a Group
        if @group.save # Attempts to save the group
            # If succesful, then attempts to create a new Location, that is linked to the group through the use of a foreign key
            @location = Location.new(location_params(@group.id))
            if @location.save # Attempts to save the new locatrion
                # If also succsful, will create a new usergroup instance using current_user.id and the group_id
                @usergroup = UserGroup.create(user_id: current_user.id, group_id: @group.id, approved: true, player_approval: true)
                @usergroup.add_role :group_admin # Adds the role of group_admin to the newly created usergroup so the user will  be considered a group_admin
                redirect_to @group #Takes the user to the newly created groups show page
            else
                @group.destroy # If the location save fails, the new group is dropped, a flash alert is created and the new page is rendered. 
                flash.alert = @location.errors.full_messages
                redirect_to new_group_path
            end
        else
            # If the group save fails, a flash alert is created and rendered on the new page.
            flash.alert = @group.errors.full_messages
            redirect_to new_group_path
        end
    end
    def find
        # Confirms that a parameter passed is considered valid
        if params[:post_code].length == 4
            # If considered valid, where query is run to find all instance of that match the parameters passed to the action
            @location = Location.where("suburb like ? AND state like ? AND post_code = ?", "%#{params[:suburb]}%", "%#{params[:state]}%", "#{params[:post_code]}")
        else
            # if the postcode is not valid, a flkash message is generated and rendered on the page
            flash.notice = "Invalid Postcode"
            redirect_to current_user
        end 
    end
    def delete
        # Destroys the group defined in the @group variable, and then takes the user back to their profile page
        @group.destroy
        redirect_to current_user
    end
    def update
        # Attempts to update @group using the new params passed to the action
        if @group.update(group_params)
            # If succesful, attempts to update the location as well
            @location = @group.location
            if @location.update(location_params(@group.id))
                # If the location saves as well, then the group show page is rendered
                redirect_to @group
            else
                # If the location save fails, the edit page is rendered with a flash alert generated at the top of the page
                flash.alert = @location.errors.full_messages
                redirect_to edit_group_path(@group)
            end
        else
             # If the group save fails, the edit page is rendered with a flash alert generated at the top of the page
            flash.alert = @group.errors.full_messages
            redirect_to edit_group_path(@group)
        end

    end
    def edit
        # Renders the edit page for forms
    end
    def attach_image
        # Action that allows a user to attach an image to the group they are on
        @group.group_images.attach(params[:group][:group_images])
        redirect_to @group
    end
    def destroy_image
        # Allows a user to delete an image associated with a group
        @image = Group.find(params[:id]).group_images.find(params[:image_id])
        @image.purge
        redirect_to group_path(params[:id])
    end
    private
    def group_params
        # Permits different parameters to be allowed into database queries for methods relating to the Groups Model, 
        params.require(:group).permit(:name, :suburb, :state, :admin_name, :group_images)
    end
    def location_params(group)
        # Permits the parameters allowed when creating or updating a location
        params[:group][:location][:group_id] = group
        params.require(:group).require(:location).permit(:suburb, :state, :post_code, :group_id)
    end
    def admin?
        # Creates the is_admin variable to be used when determining what to render on the page depending on role privileges 
        @admin =  UserGroup.where('user_id = ? and group_id = ?', current_user.id, params[:id])
        return @is_admin = (@admin.first.has_role? :group_admin) if @admin.exists?
    end
    def set_group
        # Sets the @group variable to whatever is returned by the find by id method
        @group = Group.find(params[:id])
    end
    def authorize_group
        # Runs an authortisation check on the action
        authorize @group
    end
end
