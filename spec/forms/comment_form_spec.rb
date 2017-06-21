require 'rails_helper'

RSpec.describe CommentForm, type: :model do
  let(:user) { create(:user) }
  let(:i18n_scope) { %i[activemodel errors models comment attributes] }

  let(:valid_attributes) do
    { comment: { body: 'My body', user: user } }
  end

  before do
    model = Comment.new
    @form = CommentForm.new(model)
  end

  context 'model validations rules' do
    subject { @form }

    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_absence_of(:nickname) }
    it { should allow_value(Faker::Lorem.paragraph).for(:body) }
  end

  context '#validate' do
    subject! { @form.validate(attributes) }

    context 'with correct params' do
      let(:attributes) { valid_attributes[:comment] }
      it { is_expected.to be true }
    end

    context 'with empty body attribute' do
      let(:attributes) { valid_attributes[:comment].merge!(body: nil) }

      it { is_expected.to be false }

      it 'has correct error message' do
        expect(@form.errors[:body]).to eq [t('body.blank', scope: i18n_scope)]
      end
    end

    context 'with empty user attribute' do
      let(:attributes) { valid_attributes[:comment].merge!(user: nil) }

      it { is_expected.to be false }

      it 'has correct error message' do
        expect(@form.errors[:user]).to eq [t('user.blank', scope: i18n_scope)]
      end
    end

    context 'with filled nickname attribute' do
      let(:attributes) { valid_attributes[:comment].merge!(nickname: 'I am a bot') }
      it { is_expected.to be false }
    end
  end
end
