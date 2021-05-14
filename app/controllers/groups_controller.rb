class GroupsController < ApplicationController
    def index
        # authorize User
        @groups = current_user.groups
    end
    def show
    end
end
