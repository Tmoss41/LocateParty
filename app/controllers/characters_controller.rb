class CharactersController < ApplicationController
    def new 
        @character = Character.new
    end
    def create
        @character = User.find(3).characters.create(character_params)
    end
    private

    def character_params
        params.require(:character).permit(:name, :level, :alignment, :race)
    end
end
