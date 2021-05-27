class GamesController < ApplicationController
    before_action :set_game, only: [:update, :destroy, :edit] # Runs the set_game method to set @game on
                                                                # the actions Update, Destroy and Edit
    def new 
        # Creates a variable to use as a model the form rendered on the new page, and then renders the
        # new page for the user
        @game = Game.new
    end
    def create
        @game  = Game.new(game_params) # Creates a new instance of the Game model
        if @game.save # Attempts to Save the newlty created instance, and returns a boolean value
            redirect_to group_path(@game.group.id) # If the boolean is truthy, the user is taken to the group
            # page they were initially on, with the new Game created and displayed
        else 
            # If the boolean returns false, then a flash alert is generated, and set to be rendered on the page
            # The user is then redirected to the new game url again to try again
            flash.alert = @game.errors.full_messages
            redirect_to new_game_path
        end
    end
    def destroy
        # Accepts a Delete request from the web server
        @game.destroy # Destroys the Active Record entry assigned to the variable @game
        redirect_to group_path(@game.group.id) # And then redirects the user to the group they were initially on
    end
    def edit
        # Renders the Edit.html.erb which contains the edit form for games
    end
    def update
        # Accepts a post request from the edit page
        @game.update(game_params) # Updates the Active Record instance defined by the variable @game, with
                                    # With the new variables defined in game_parms
        redirect_to group_path(@game.group.id) # And redirects the user to the group show page they were on. 
    end
    private
    def game_params
        # Sanitises the parameters and only allows certain parameters to be passed to the method
        params.require(:game).permit(:name, :date, :time, :group_id)
    end
    def set_game
        # Sets the variable @game, to find the game that matches the id passed to it. 
        @game = Game.find(params[:id])
    end
end
