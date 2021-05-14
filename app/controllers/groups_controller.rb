class GroupsController < ApplicationController
    def index
        # authorize User
        @groups = current_user.groups
    end
    def show
       @group = Group.find(params[:id]) 
       session[:current_group] = params[:id]
    end
    def new
        @group = Group.new
    end
    def create
        @group = current_user.groups.create(group_params)
        redirect_to groups_path
    end
    def find
        @groups = Group.all
    end
    private
    def group_params
        params.require(:group).permit(:name)
    end
end
