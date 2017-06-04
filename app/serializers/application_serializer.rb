class ApplicationSerializer < ActiveModel::Serializer
  include ApplicationHelper
  include ActionView::Helpers::AssetTagHelper
  include Rails.application.routes.url_helpers
end
