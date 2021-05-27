class CharacterPolicy
    attr_reader :character, :user
    def initialize(user, character)
        @user = user
        @character = character
    end
    def new?
        # Runs the owner_of_page? method to check that the user is authorised to make a change to a character
        owner_of_page?
    end
    def update?
        # Runs the owner? method to confirm that the current_user is the owner of the character
        owner?
    end
    def delete?
        # Runs the owner? method to confirm that the current_user is the owner of the character
        owner?
    end
    private
    def owner?
        # Checks the current_user's chracter list, and confirms whether the character exists in their list, if theyy do have the character, the methods returns true
        # Otherwise it will return false
        @owner = user.characters.where(id: character.id).present?
        if @owner
            return true
        else 
            return false
        end
    end
    def owner_of_page?
        # Checks that the person attempting to make changes to the page, is the owner of the page 
        # by compairng the current_user id with the params[:id] of the page
        # and returns a boolean value depending on the result 
        !!user == params[:id]
    end
end