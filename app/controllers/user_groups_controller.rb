class UserGroupsController < ApplicationController
  before_action :set_group_id, only: [:join]
  before_action :set_group_and_user_params, only: [:approved]
  def join
    # Creates a new entry under UserGroup model, using the current_user's database id and a pre-configured session entry
      @query = UserGroup.create(user_id: current_user.id, group_id: @group, approved: false)
      redirect_to current_user
  end
  def approved
    UserGroup.where(['user_id = ? and group_id = ?' , params[:user_group][:user_id], params[:user_group][:group_id]]).update(approved: true)
    # render json: params
  end
  private 
  def set_group_id
    # sets the session to a variable
    @group = session[:current_group]
  end
  def set_group_and_user_params
    params.require(:user_group).permit(:user_id, :group_id)
  end
end
