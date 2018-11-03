module Api
  module V1
    class ApplicationController < ErrorsController
      include Pundit
      include Knock::Authenticable
    end
  end
end

