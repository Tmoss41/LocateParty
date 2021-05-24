class LocationsController < ApplicationController
  def find
    @locations = Location.where('post_code = ?', params[:post_code])
  end
  private
  def set_params
    params.permit(:post_code)
  end
end
