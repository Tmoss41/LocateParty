class CharactersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_character, only: [:edit, :show, :update]
    def new 
        @character = Character.new
    end
    def create
        @character = current_user.characters.new(character_params)
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
        @character = Character.find(params[:id])
        authorize @character
        @character.destroy
        redirect_to current_user
    end
    private
    def character_params
        params.require(:character).permit(:name, :level, :alignment, :race, :character_class)
    end
    def set_character
        @character = Character.find(params[:id])
        @owner = @character.user
    end
end
