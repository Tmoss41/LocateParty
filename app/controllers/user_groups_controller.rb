class UserGroupsController < ApplicationController
  before_action :set_group_id, only: [:join]
  def join
    # Creates a new entry under UserGroup model, using the current_user's database id and a pre-configured session entry
      @query = UserGroup.create(user_id: current_user.id, group_id: @group)
      redirect_to current_user
  end
  private 
  def set_group_id
    # sets the session to a variable
    @group = session[:current_group]
  end
end
