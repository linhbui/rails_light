require_relative '../phase3/controller_base'
require_relative './session'

module Phase4
  class ControllerBase < Phase3::ControllerBase
    def redirect_to(url)
      super(url)
      @session.store_session(res)
    end

    def render_content(content, type)
      super(content, type)
      @session.store_session(res)
    end

    # Create a session from a request
    def session
      @session ||= Session.new(@req)
    end
  end
end
