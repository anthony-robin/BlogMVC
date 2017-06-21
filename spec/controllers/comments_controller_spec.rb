require 'rails_helper'

RSpec.describe CommentsController do
  let(:blog) { create(:blog) }

  let(:valid_params) do
    { comment: { commentable: blog, body: Faker::Lorem.paragraph } }
  end

  let(:invalid_params) do
    valid_params[:comment].merge!(body: nil)
    valid_params
  end

  describe 'POST #create' do
    context 'when authenticated' do
      login_user

      context 'with HTML format' do
        subject { post :create, params: { blog_id: blog, comment: attributes } }

        context 'with valid params' do
          let(:attributes) { valid_params[:comment] }
          before { subject }

          it 'has correct owner' do
            expect(assigns(:comment).user).to eq(@admin)
          end

          it_behaves_like :comment_creatable
        end

        context 'with invalid params' do
          let(:attributes) { invalid_params[:comment] }
          before { subject }

          it { is_expected.to have_http_status(302) }
          it { is_expected.to redirect_to(category_blog_url(blog.category, blog)) }

          it 'has correct flash alert' do
            expect(controller).to set_flash[:alert].to(t('comments.create.alert'))
          end

          it_behaves_like :comment_not_creatable
        end

        context 'with captcha filed' do
          let(:attributes) { valid_params[:comment].merge!(nickname: 'I AM A ROBOT') }
          before { subject }

          it { is_expected.to have_http_status(302) }
          it { is_expected.to redirect_to(category_blog_url(blog.category, blog)) }

          it 'has correct flash alert' do
            expect(controller).to set_flash[:alert].to(t('comments.create.alert'))
          end

          it_behaves_like :comment_not_creatable
        end
      end

      context 'with JS format' do
        subject { post :create, params: { blog_id: blog, comment: attributes }, format: :js }

        context 'with valid params' do
          let(:attributes) { valid_params[:comment] }
          before { subject }

          it { is_expected.to have_http_status(200) }
          it { is_expected.to render_template(:create) }
        end

        context 'with invalid params' do
          let(:attributes) { invalid_params[:comment] }
          before { subject }

          it { is_expected.to have_http_status(200) }
          it { is_expected.to render_template(:error) }
        end
      end
    end

    context 'when not authenticated' do
      context 'with HTML format' do
        subject! { post :create, params: { blog_id: blog, comment: valid_params } }

        it_behaves_like :redirected_request, 'new_user_session_url'
        it_behaves_like :comment_not_creatable
      end

      context 'with JS format' do
        subject! { post :create, params: { blog_id: blog, comment: valid_params }, format: :js }

        it_behaves_like :unauthorized_request
        it_behaves_like :comment_not_creatable
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:blog) { create(:blog, user: user) }
    let(:comment) { create(:comment, commentable: blog, user: user) }

    context 'when authenticated' do
      before { sign_in user }

      context 'with HTML format' do
        subject! { delete :destroy, params: { blog_id: blog, id: comment } }

        it_behaves_like :comment_destroyable
      end

      context 'with JS format' do
        subject! { delete :destroy, params: { blog_id: blog, id: comment }, format: :js }

        it_behaves_like :ok_request, :destroy
        it_behaves_like :comment_destroyable
      end
    end

    context 'when not authenticated' do
      context 'with HTML format' do
        subject! { delete :destroy, params: { blog_id: blog, id: comment } }

        it_behaves_like :redirected_request, 'new_user_session_url'
        it_behaves_like :comment_not_destroyable
      end

      context 'with JS format' do
        subject! { delete :destroy, params: { blog_id: blog, id: comment }, format: :js }

        it_behaves_like :unauthorized_request
        it_behaves_like :comment_not_destroyable
      end
    end
  end
end
