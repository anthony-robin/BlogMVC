module ApplicationHelper
  def website_conf
    @website_conf ||= Rails.configuration.website
  end
end
