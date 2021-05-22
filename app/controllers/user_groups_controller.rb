class UserGroupsController < ApplicationController
  before_action :set_group_and_user_params, only: [:approved, :join]
  def join
    # Creates a new entry under UserGroup model, using the current_user's database id and a pre-configured session entry
      @query = UserGroup.create(set_group_and_user_params)
      render plain: @query.errors.full_messages
      # redirect_to current_user
  end
  # The Approved action, allows a user that requested to join a group to be allowed to see the group details
  def approved
    UserGroup.where(['user_id = ? and group_id = ?' , params[:user_id], params[:group_id]]).update(approved: true)
    redirect_to current_user
    # render json: params
  end
  def accept_invite
    UserGroup.where(['user_id = ? and group_id = ?' , params[:user_id], params[:group_id]]).update(player_approval: true)
    redirect_to current_user
  end
  # This action is used in two scenarios. It is used to remove entries from the UserGRoup Join Table, 
  # i.e either a user that is already a part of a group, where they will then be removed from the group
   # or a request to join a group which has been rejected will then be removed. 
  def destroy_member_in_group
    @user = UserGroup.where(['user_id = ? and group_id = ?' , params[:user_id], params[:group_id]])
    @user.destroy_all
    if @user.approved == true
      redirect_to group_path(params[:group_id])
    else 
      redirect_to current_user
    end
  end
  private 
  def show
    @usergroup = UserGroup.where("group_id = #{params[:id]}")
  end
  
  private 
  def set_group_and_user_params
    params.permit(:group_id, :user_id, :approved, :player_approval)
  end
  
end
