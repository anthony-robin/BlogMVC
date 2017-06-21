class ActionDispatch::Routing::Mapper
  # Read route file
  #
  # @param [Array] Symbols representing route file path
  def draw(*routes_name)
    instance_eval(File.read(Rails.root.join('config', 'routes', "#{routes_name.join('/')}.rb")))
  end
end
