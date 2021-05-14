class UserGroupsController < ApplicationController
  before_action :set_group_id, only: [:join]
  def join
      @query = UserGroup.create(user_id: current_user.id, group_id: @group)
      redirect_to current_user
  end
  private 
  def set_group_id
    @group = session[:current_group]
  end
end
