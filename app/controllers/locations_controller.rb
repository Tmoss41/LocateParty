class LocationsController < ApplicationController
  # The find action relates to the form in the navigation bar that users can use to search for players or groups via post code
  def find
      if  post_code_valid? # Runs the method post_code_valid, and returns a boolean value
        # If the boolean is true, then the @location variable is created and assigned 
        # the results of the database query run by the where method, to find all instances of the matching post_code
        @locations = Location.where('post_code = ?', params[:post_code])
      else 
        # If the check returns false, a Standard Error is raised, recsued and a flash alert is created, where the user is taken back to their profile page
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
    # Sets the allowed parameters to be passed to this controller
    params.permit(:post_code)
  end
  def post_code_valid?
    # Checks that the post_code only has 4 characters, aka is a valid post_code
    params[:post_code].length == 4
  end
end
