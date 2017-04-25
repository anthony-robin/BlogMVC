require 'rails_helper'

describe ApplicationHelper do
  describe '#website_conf' do
    it 'returns same object' do
      expect(website_conf).to eq Rails.configuration.website
    end

    it 'has correct keys' do
      expect(website_conf).to include('title')
    end
  end
end
