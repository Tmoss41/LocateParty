class UserGroupsController < ApplicationController
  def add
    @query = UserGroup.create(user_id: current_user.id, group_id: group.id)
  end
end
