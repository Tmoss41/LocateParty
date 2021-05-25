class LocationPolicy
    def initialize(user, postcode)
        @user = user
        @postcode = postcode
    end
    def find?
        !!@postcode.length == 4
    end
end