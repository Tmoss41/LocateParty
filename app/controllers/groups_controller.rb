class GroupsController < ApplicationController
    def index
        authorize User
    end
end
