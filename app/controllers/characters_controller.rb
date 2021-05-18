class CharactersController < ApplicationController
    def new 
        @character = Character.new
    end
    def create
        @character = current_user.characters.create(character_params)
        redirect_to current_user
    end
    def show
        @character = current_user.characters.find(params[:id])
    end
    def edit
        @character = current_user.characters.find(params[:id])
    end
    def update
        @character = current_user.characters.find(params[:id])
        @character.update(character_params)
        redirect_to current_user
    end
    def delete
        Character.find(params[:id]).destroy
        redirect_to current_user
    end
    private

    def character_params
        params.require(:character).permit(:name, :level, :alignment, :race, :character_class)
    end

end
