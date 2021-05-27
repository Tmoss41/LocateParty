class CharactersController < ApplicationController
    before_action :authenticate_user! # Validates that the user is signed in before each action, should they not be logged in Devise will redirect the user to the main root path and display a flash alert
    before_action :set_character, only: [:edit, :update, :show] # Runs the method set_character before the edit and update actions
    def new 
        # Creates a new instance of Character, to be used as a model in the form on the new.html.erb file in the Views/Characters folder
        @character = Character.new
        # Then renders the new view
    end
    def show
        # Renders an individual character for the user to view
    end
    def create
        # Accepts post request from new page/new action
        # Creates a ne instance of charcter model, using the relationship between User and Character, and uses the charatcer_params method to set the column values
        # (Current_user was used to force all new characters to be created for the user logged in, preventing another user from creating a character for another user)
        @character = current_user.characters.new(character_params)
        if @character.save # Attempts to save the new instance of character, and returns a boolean based on the result
            # If successful, the user is redirected to their profile show page
            redirect_to current_user
        else 
            # If the save fails, a flash alert messgae is generated with the errors the action encountered as the content
            flash.alert = @character.errors.full_messages
            # And the user is then redirected to the same page to try again.
            redirect_to new_character_path
        end
    end
    def edit
        # Accepts gets request from server, and then renders a page to edit the details of the character params passes to the action. 
    end
    def update
        # Accepts a post request from the edit page and its form
        authorize @character # Runs an authorization check using the current_user and @character as the arguments (The methods relating to this can be found in the folder, 'app/policies/character_policy.rb')

        if @character.update(character_params)   # If the authorisation passes, then the instance of @character will attempt to be updated using the parameters allowed in the character_params method
            # if successful then the user is redirected to their profile page
            redirect_to current_user
        else 
            # If the update fails then a flash alert is generated and the edit page and form is reloaded for them to try again
            flash.alert = @character.errors.full_messages
            redirect_to edit_character_path(@character)
        end
    end
    def delete
        # Accepts Delete request
        authorize @character # Runs an authorisation check using Pundit
        @character.destroy # If authorisation is succesful, then the instance defined in @character is dropped from the character table
        redirect_to current_user # and the user is redirected to their profiel page
    end
    private
    def character_params
        # Sets the allowed parameters when receiving information from the views
        params.require(:character).permit(:name, :level, :alignment, :race, :character_class)
    end
    def set_character
        # Sets the @character variable which is used in the show, edit and update actions.
        @character = Character.find(params[:id])
        @owner = @character.user
    end
end
