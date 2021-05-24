class GamePolicy
    def initialize(user, game)
        @user = user
        @game = game
    end
    private
    def admin?(user, game)
        @admin = user.user_groups.where(user_id: user.id, group_id: group.id).first
        if @admin.class != NilClass
            case @admin.has_role? :group_admin
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
        role = admin?(@user, @group)
        case role
        when true 
            return true
        when false
            raise Pundit::NotAuthorizedError
        end
    end
end