class LocationsController < ApplicationController
  def find
      if  post_code_valid?
        # raise StandardError 
        @locations = Location.where('post_code = ?', params[:post_code])
      else 
        # raise StandardError
        begin
          raise StandardError
        rescue StandardError
          flash.alert = "Postcode is not a valid postcode"
          redirect_to current_user
        end
    end
  end
  
  private
  def set_params
    params.permit(:post_code)
  end
  def post_code_valid?
    params[:post_code].length == 4
  end
end
