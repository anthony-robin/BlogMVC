module Assets::Picturable
  extend ActiveSupport::Concern

  included do
    has_one :picture, as: :attachable, dependent: :destroy
    accepts_nested_attributes_for :picture,
                                  reject_if: :all_blank,
                                  allow_destroy: true
  end

  def picture?
    picture.present?
  end
end
