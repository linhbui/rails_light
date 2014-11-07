require_relative '../phase2/controller_base'
require 'active_support/core_ext'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    def render(template_name)
      # Create the file path
      file = File.join(
        "views", self.class.name.underscore, "#{template_name}.html.erb")
      # Read the actual file  
      erb_code = File.read(file)
      # Render the template
      # Binding is used to capture the controller's instance variables
      render_content(ERB.new(erb_code).result(binding), "text/html")  
    end
  end
end
