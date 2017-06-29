require 'rails_helper'

RSpec.describe CommentsController do
  let!(:user) { create(:user, :admin) }
  let!(:blog) { create(:blog, user: user) }

  let(:valid_attributes) do
    { comment:
      { commentable: blog,
        body: Faker::Lorem.paragraph } }
  end

  let(:invalid_attributes) do
    valid_attributes[:comment].merge!(body: nil)
    valid_attributes
  end

  before { login_user user }

  describe 'POST #create' do
    let(:attributes) { valid_attributes[:comment] }

    subject do
      post :create,
        params: { blog_id: blog, comment: attributes },
        format: format
    end

    context 'when not logged in' do
      it_behaves_like :not_logged_in
    end

    context 'when logged in' do
      context 'with HTML format' do
        let(:format) { :html }

        context 'with valid params' do
          it_behaves_like :comment_creatable
        end

        context 'with invalid params' do
          let(:attributes) { invalid_attributes[:comment] }

          it_behaves_like :comment_not_creatable
        end

        context 'with captcha filed' do
          let(:attributes) do
            valid_attributes[:comment].merge!(nickname: 'I AM A ROBOT')
          end

          it_behaves_like :comment_not_creatable
        end
      end

      context 'with JS format' do
        let(:format) { :js }

        context 'with valid params' do
          it { is_expected.to have_http_status(200) }
          it { is_expected.to render_template :create }
        end

        context 'with invalid params' do
          let(:attributes) { invalid_attributes[:comment] }

          it { is_expected.to have_http_status(200) }
          it { is_expected.to render_template :error }
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { create(:comment, commentable: blog, user: user) }

    subject do
      delete :destroy,
        params: { blog_id: blog, id: comment },
        format: format
    end

    context 'when not logged in' do
      it_behaves_like :not_logged_in
    end

    context 'when logged in' do
      context 'with HTML format' do
        let(:format) { :html }

        it_behaves_like :comment_destroyable
      end

      context 'with JS format' do
        let(:format) { :js }

        it { is_expected.to have_http_status(200) }
        it { is_expected.to render_template :destroy }

        it_behaves_like :comment_destroyable
      end
    end
  end
end
