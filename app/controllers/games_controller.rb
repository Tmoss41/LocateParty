class GamesController < ApplicationController
    def index
        @game = Game.all
    end
    def new 
        @game = Game.new
        @group = current_user.groups
    end
    def create
        @game  = Game.create(game_params)
        redirect_to current_user
    end
    private
    def game_params
        params.require(:game).permit(:name, :date, :time, :group_id)
    end
end
