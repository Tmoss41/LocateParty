class CharactersController < ApplicationController
    def new 
        @character = Character.new
    end
def create
        @character = current_user.characters.create(character_params)
        redirect_to current_user
    end
    private

    def character_params
        params.require(:character).permit(:name, :level, :alignment, :race, :character_class)
    end
end
