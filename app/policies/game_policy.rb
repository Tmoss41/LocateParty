class GamePolicy
    # Authorisation Polciy for the Game Model using Pundit Gem
    def initialize(user, game)
        # Passes the arguments from the model to be authorised
        @user = user
        @game = game
    end
    private
    def admin?(user, game)
        # Confirms that the current user is an admin
        @admin = user.user_groups.where(user_id: user.id, group_id: group.id).first # Checks the usergroups of the current_user, for an entry where the group_id is present
        if @admin.class != NilClass # Confirms that the UserGRoup entry is not nil
            case @admin.has_role? :group_admin # If the previous check passes, confirms whether the UserGRoup entry has the group_admin role assigned to it and 
                                                # And returns true or false depending on the result
            when true
                return true
            else
                return false
            end
        else 
            return false
        end
    end
    def authorize_admin
        role = admin?(@user, @group) # Takes the Admin method and passes it the instanced variables defined in the initilize method
        case role # Returns true or false pending on the result of the method, and will raise an error if it fails
        when true 
            return true
        when false
            raise Pundit::NotAuthorizedError
        end
    end
end