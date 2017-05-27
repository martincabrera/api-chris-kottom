module Authentication
  module JWT
    module Helpers
      def auth_headers_token(options = {})
        user = options[:user] || users(:admin)
        token = Knock::AuthToken.new(payload: {sub: user.id}).token
        #{'Authorization': "Bearer #{ token }"}
        token
      end
    end
  end
end