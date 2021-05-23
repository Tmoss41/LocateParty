class GroupPolicy
    attr_reader :user, :group
    def initialize(user, group)
        @user = user
        @group = group
    end
    def make_admin?
        @user_check = @user.usergroups.where(user_id: @user.id, group_id: @group.id).first
        return @user_check.has_role? :group_admin
    end
    def edit? 
        authorize_admin
    end
    def update?
        authorize_admin
    end
    def delete?
        authorize_admin
    end
    def new?
        signed_in?
    end
    def create? 
        signed_in?
    end
    private 
    def admin?(user, group)
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
    def signed_in?
        case @user.class != NilClass
        when true
            return true
        when false
            return false
        end
    end
end