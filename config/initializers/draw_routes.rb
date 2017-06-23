module ActionDispatch
  module Routing
    class Mapper
      # Read route file
      #
      # @param [Array<Symbol>] route file path
      def draw(*routes_name)
        instance_eval(File.read(Rails.root.join('config', 'routes', "#{routes_name.join('/')}.rb")))
      end
    end
  end
end
