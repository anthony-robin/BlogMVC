require 'rails_helper'

describe CommentsController do
  let(:blog) { create(:blog) }
  let!(:valid_params) do
    { commentable: blog, body: 'Lorem ipsum !' }
  end
  let!(:invalid_params) do
    valid_params.merge(body: nil)
  end

  describe 'POST #create' do
    context 'when authenticated' do
      login_user

      context 'with HTML format' do
        context 'with valid params' do
          before do
            post :create, params: { blog_id: blog, comment: valid_params }
          end

          it { is_expected.to respond_with 302 }
          it { is_expected.to redirect_to(category_blog_url(blog.category, blog)) }

          it 'should create a new comment' do
            expect {
              post :create, params: { blog_id: blog, comment: valid_params }
            }.to change(Comment, :count).by(1)
          end

          it 'should have correct flash success' do
            expect(flash[:success]).to eq(t('comments.create.success'))
          end

          it 'should have correct user owner' do
            expect(assigns(:comment).user).to eq(@admin)
          end
        end

        context 'with invalid params' do
          before do
            post :create, params: { blog_id: blog, comment: invalid_params }
          end

          it { is_expected.to respond_with 302 }
          it { is_expected.to redirect_to(category_blog_url(blog.category, blog)) }
          it_behaves_like :comment_not_creatable

          it 'should have correct flash alert' do
            expect(flash[:alert]).to eq(t('comments.create.alert'))
          end
        end

        context 'with captcha filed' do
          before do
            post :create, params: { blog_id: blog, comment: valid_params.merge(nickname: 'I AM A ROBOT') }
          end

          it { is_expected.to respond_with 302 }
          it { is_expected.to redirect_to(category_blog_url(blog.category, blog)) }
          it_behaves_like :comment_not_creatable

          it 'should have correct flash alert' do
            expect(flash[:alert]).to eq(t('comments.create.alert'))
          end
        end
      end

      context 'with JS format' do
        context 'with valid params' do
          before do
            post :create, params: { blog_id: blog, comment: valid_params }, xhr: true
          end

          it { is_expected.to respond_with 200 }
          it { is_expected.to render_template(:create) }
        end

        context 'with invalid params' do
          before do
            post :create, params: { blog_id: blog, comment: invalid_params }, xhr: true
          end

          it { is_expected.to respond_with 200 }
          it { is_expected.to render_template(:error) }
        end
      end
    end

    context 'when not authenticated' do
      context 'with HTML format' do
        before do
          post :create, params: { blog_id: blog, comment: valid_params }
        end

        it_behaves_like :redirected_request, 'new_user_session_url'
        it_behaves_like :comment_not_creatable
      end

      context 'with JS format' do
        before do
          post :create, params: { blog_id: blog, comment: valid_params }, format: :js
        end

        it_behaves_like :unauthorized_request
        it_behaves_like :comment_not_creatable
      end
    end
  end
end
