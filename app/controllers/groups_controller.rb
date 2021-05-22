class GroupsController < ApplicationController
    before_action :admin?, only: :show
    def show
        @group = Group.find(params[:id])
        # Shows a specific group based on the id passed through from the webpage of the user=
       
       
    end
    def new
        # Saves a place in memory for a new  instance of a group and then redirects user to the new.html.erb page found in /views/groups
        @group = Group.new
    end
    def create
        # Takes data from the form on the new.html.erb page and creates a add query to the database using the parameters defined in private method, from webpage
        @group = current_user.groups.new(group_params)
        if @group.save
            @usergroup = UserGroup.create(user_id: current_user.id, group_id: @group.id, approved: true, player_approval: true)
            @usergroup.add_role :group_admin
            redirect_to current_user
        else
            flash.alert = 'Group Name Taken, please try again'
            redirect_to new_group_path
        end    
        # render plain: @group.errors.full_messages
    end
    def find
        @groups = Group.where("name LIKE ? AND suburb like ? AND state like ?", "%#{params[:name]}%", "%#{params[:suburb]}%", "%#{params[:state]}%")
    end
    def delete
        Group.find(params[:id]).destroy
        redirect_to current_user
    end
    def update
        @group = Group.find(params[:id])
        @group.update(group_params)
        redirect_to @group
    end
    def edit
        @group = Group.find(params[:id])
    end
    def destroy_image
        @image = Group.find(params[:id]).group_images.find(params[:image_id])
        @image.purge
        redirect_to group_path(params[:id])
    end
    private
    def group_params
        # Permits different parameters to be allowed into database queries for methods relating to the Groups Model, 
        params.require(:group).permit(:name, :suburb, :state, :admin_name, :group_images)
    end
    def admin?
        @admin =  UserGroup.where('user_id = ? and group_id = ?', current_user.id, params[:id])
        return @is_admin = (@admin.first.has_role? :group_admin) if @admin.exists?
    end
end
