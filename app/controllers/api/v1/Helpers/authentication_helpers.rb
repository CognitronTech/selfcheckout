  module API
  module V1
   module Helpers
    module AuthenticationHelpers
      extend Grape::API::Helpers
       def current_user
            user = User.where(authentication_token: params[:access_token]).first
            if user
              @current_user = user
            else
              false
            end
        end

          def authenticate!
            error!('401 Unauthorized', 401) unless current_user
          end
    end
  end
 end
end