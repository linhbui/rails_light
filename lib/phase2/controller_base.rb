module Phase2
  class ControllerBase
    attr_reader :req, :res

    # Setup the controller
    def initialize(req, res)
      @req, @res = req, res
      @already_built_response = false
    end

    # Helper method to alias @already_built_response
    def already_built_response?
      @already_built_response
    end

    # Set the response status code and header
    def redirect_to(url)
      raise "double render error" if @already_built_response
      
      @res.status = 302
      @res.header["location"] = url
      @already_built_response = true
    end

    def render_content(content, type)
      raise "double render error" if @already_built_response
      # Populate the response with content.
      @res.body = content
      # Set the response's content type to the given type.
      @res.content_type = type
      # Raise an error if the developer tries to double render.
      @already_built_response = true
    end
  end
end
