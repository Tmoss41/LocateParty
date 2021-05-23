class CharacterPolicy
    attr_reader :character, :user
    def initialize(user, character)
        @user = user
        @character = character
    end
    def create?
        signed_in?
    end
    def new?
        signed_in?
    end
    def edit?
        signed_in?
    end
    def update?
        signed_in?
    end
    private
    def signed_in?
        case @user.class != NilClass
        when true
            return true
        when false
            return false
        end
    end
    def owner?
        !!user.id == params[:id]
    end
end