RSpec.configure do |config|
  if Bullet.enable?
    config.before { Bullet.start_request }
    config.after { Bullet.end_request }
  end
end
