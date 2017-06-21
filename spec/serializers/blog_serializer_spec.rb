require 'rails_helper'

RSpec.describe BlogSerializer, type: :serializer do
  let(:blog) { create(:blog) }
  subject { serialize(blog) }

  it 'includes the expected attributes' do
    expected = {
      id: blog.id,
      title: blog.title,
      content: blog.content
    }.to_json

    expect(subject).to eq expected
  end
end
