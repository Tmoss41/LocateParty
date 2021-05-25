class ProfilePolicy
    def initialize(user, profile)
        @user = user
        @profile = profile
    end
    def update?
        if owner?
            return true
        else 
            return false
        end
    end
    def owner?
        @owner = @user.id == @profile.user.id
        !!@owner
    end
end