# This concern is a dirty fix to speedup BetterError pages
# https://github.com/charliesome/better_errors/issues/341#issuecomment-295963626
#
module FixBetterError
  extend ActiveSupport::Concern

  included do
    before_action :better_errors_hack,
                  if: -> { Rails.env.development? }
  end

  def better_errors_hack
    request.env['puma.config'].options.user_options.delete :app
  end
end
