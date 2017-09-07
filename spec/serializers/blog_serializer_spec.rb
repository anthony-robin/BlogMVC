require 'rails_helper'

RSpec.describe BlogSerializer, type: :serializer do
  subject(:json) { serialize(blog) }

  let(:blog) { create(:blog) }

  it 'includes the expected attributes' do
    expected = {
      id: blog.id,
      title: blog.title,
      content: blog.content
    }.to_json

    expect(json).to eq expected
  end
end
