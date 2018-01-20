Ribbonit.configure do |config|
  config.infos_to_display = %i[rails_version ruby_version git_branch]
  config.root_link = true
  config.hide_for_small = true
  config.position = 'top-left'
  config.sticky = true

  config.themes = {
    development: 'orange',
    staging: 'blue'
  }
end
