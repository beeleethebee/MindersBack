class ApplicationController < ActionController::Base
    include DeviseTokenAuth::Concerns::SetUserByToken
    helper_method :current_user
end
