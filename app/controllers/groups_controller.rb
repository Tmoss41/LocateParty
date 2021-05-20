class GroupsController < ApplicationController
    before_action :admin?
    def index
        # Checks the database for all groups assigned to the current user 
        @groups = current_user.groups
    end
    def show
        @group = Group.find(params[:id])
        # Shows a specific group based on the id passed through from the webpage of the user
       session[:current_group] = params[:id]
       @params_pass = UserGroup.new
       
    end
    def new
        # Saves a place in memory for a new  instance of a group and then redirects user to the new.html.erb page found in /views/groups
        @group = Group.new
    end
    def create
        current_user.add_role :admin
        # Takes data from the form on the new.html.erb page and creates a add query to the database using the parameters defined in private method, from webpage
        @group = current_user.groups.new(group_params)
        if @group.save
            UserGroup.create(user_id: current_user.id, group_id: @group.id, approved: true)
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
    def delete_member
        render json: params
    end
    private
    def group_params
        # Permits different parameters to be allowed into database queries for methods relating to the Groups Model, 
        params.require(:group).permit(:name, :suburb, :state, :admin_name)
    end
    def admin?
        return @admin = current_user.has_role?(:admin)
    end
end
