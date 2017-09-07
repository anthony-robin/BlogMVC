require 'rails_helper'

RSpec.describe Blogs::AutocompleteSerializer, type: :serializer do
  include Rails.application.routes.url_helpers

  subject(:json) { serialize(blog, serializer_class: described_class) }

  let(:blog) { create(:blog) }

  it 'includes the expected attributes' do
    expected = {
      title: blog.title,
      url: category_blog_path(blog.category, blog)
    }.to_json

    expect(json).to eq expected
  end
end
