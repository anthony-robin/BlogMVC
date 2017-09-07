require 'rails_helper'

RSpec.describe Blogs::SearchesController do
  let!(:blogs) { create_list(:blog, 3) }

  before do
    create(:blog, title: 'Lorem ipsum')
    Blog.reindex
  end

  describe 'GET #index' do
    context 'without query' do
      subject { get :index }

      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to blogs_path }
    end

    context 'with query' do
      subject! do
        get :index,
          params: { term: term }
      end

      context 'when empty' do
        let(:term) { '' }

        it { is_expected.to have_http_status(302) }
        it { is_expected.to redirect_to blogs_path }
      end

      context 'when filled' do
        let(:term) { 'article' }
        let(:results) { assigns(:blogs).results }

        it 'has correct articles' do
          expect(results).to eq [blogs[0], blogs[1], blogs[2]]
        end

        it { is_expected.to have_http_status(200) }
        it { is_expected.to render_template 'blogs/index' }
      end
    end
  end
end
