class ApplicationController < ErrorsController
  include Pundit
  include Knock::Authenticable
end
