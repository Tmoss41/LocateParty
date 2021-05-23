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
    def update?
        @admin = @user.user_groups.where(user_id: @user.id, group_id: @group.id).first
        if @admin.class != NilClass
            case @admin.has_role? :group_admin
            when true
                return true
            else
                raise Pundit::NotAuthorizedError
            end
        else 
            raise Pundit::NotAuthorizedError
        end
    end
end