module ApplicationHelper
  def website_conf
    @website_conf ||= Rails.configuration.website
  end

  def retina_image_tag(model, mounted_to, version, options = {})
    options.symbolize_keys!
    options[:srcset] ||= (2..3).map do |multiplier|
                            name = "#{version}_#{multiplier}x"
                            if model.send(mounted_to).version_exists?(name) &&
                              source = model.send(mounted_to).url(name).presence
                              "#{source} #{multiplier}x"
                            else
                              nil
                            end
                          end.compact.join(', ')

    image_tag(model.send(mounted_to).url(version), options)
  end
end
