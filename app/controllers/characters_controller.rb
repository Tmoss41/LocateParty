class CharactersController < ApplicationController
    before_action :set_character, only: [:edit, :show, :update]
    def new 
        @character = Character.new
        authorize @character
    end
    def create
        @character = current_user.characters.new(character_params)
        authorize @character
        if @character.save
            redirect_to current_user
        else 
            flash.alert = @character.errors.full_messages
            redirect_to new_character_path
        end
    end
    def show
    end
    def edit
    end
    def update
        authorize @character
        if @character.update(character_params)
            redirect_to current_user
        else 
            flash.alert = @character.errors.full_messages
            redirect_to edit_character_path(@character)
        end
    end
    def delete
        Character.find(params[:id]).destroy
        redirect_to current_user
    end
    private
    def character_params
        params.require(:character).permit(:name, :level, :alignment, :race, :character_class)
    end
    def set_character
        @character = current_user.characters.find(params[:id])
    end
end
