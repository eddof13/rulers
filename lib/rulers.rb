require "rulers/version"
require "rulers/array"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"
require "rulers/controller"
require "rulers/file_model"

module Rulers
  class Error < StandardError; end
  
  class Application
    def call(env)
      `echo debug > debug.txt`;
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      res = controller.get_response
      if res
        [res.status, res.headers, [res.body].flatten]
      else
        [200, {'Content-Type' => 'text/html'}, [text]]
      end
    end
  end
end
