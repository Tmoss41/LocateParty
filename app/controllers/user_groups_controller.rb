class UserGroupsController < ApplicationController
  before_action :set_group_id, only: [:join]
  before_action :set_group_and_user_params, only: [:approved]
  def join
    # Creates a new entry under UserGroup model, using the current_user's database id and a pre-configured session entry
      @query = UserGroup.create(user_id: current_user.id, group_id: @group, approved: false)
      redirect_to current_user
  end
  def approved
    UserGroup.where(['user_id = ? and group_id = ?' , params[:user_id], params[:group_id]]).update(approved: true)
    redirect_to current_user
    # render json: params
  end
  def destroy_member_in_group
    UserGroup.where(['user_id = ? and group_id = ?' , params[:user_id], params[:group_id]]).destroy_all
    redirect_to group_path(params[:group_id])
  end
  private 
  def set_group_id
    # sets the session to a variable
    @group = session[:current_group]
  end
  def show
    @usergroup = UserGroup.where("group_id = #{params[:id]}")
  end
  
  private 
  def set_group_and_user_params
    params.permit(:group_id, :user_id)
  end
  
end
