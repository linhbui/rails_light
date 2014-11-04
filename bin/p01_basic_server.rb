require 'webrick'

server = WEBrick::HTTPServer.new(:Port => 3000)

server.mount_proc("/") do |request, response|
    response.content_type = "text/text"
    response.body = request.path
end

trap('INT') { server.shutdown }

server.start