class Api::SessionsController < DeviseTokenAuth::SessionsController
  protect_from_forgery with: :null_session, prepend: true
end
