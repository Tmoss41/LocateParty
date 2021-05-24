class CharacterPolicy
    attr_reader :character, :user
    def initialize(user, character)
        @user = user
        @character = character
    end
    def new?
        owner_of_page?
    end
    def update?
        owner?
    end
    def delete?
        owner?
    end
    private
    def owner?
        @owner = user.characters.where(id: character.id).present?
        if @owner
            return true
        else 
            return false
        end
    end
    def owner_of_page?
        !!user == params[:id]
    end
end