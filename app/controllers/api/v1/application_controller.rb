class Api::V1::ApplicationController < Api::V1::ErrorsController
  include Pundit
  include Knock::Authenticable
end
