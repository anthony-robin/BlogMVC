require 'rails_helper'

RSpec.describe BlogForm, type: :model do
  let(:category) { create(:category) }
  let(:i18n_scope) { %i[activemodel errors models blog attributes] }

  let(:valid_attributes) do
    { blog: { title: Faker::Lorem.sentence,
              content: Faker::Lorem.paragraph,
              category_id: category.id.to_s } }
  end

  let(:form) { BlogForm.new(Blog.new) }

  describe 'model validations rules' do
    subject { form }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:category_id) }

    it { is_expected.to allow_value(Faker::Lorem.sentence).for(:title) }
    it { is_expected.to allow_value(Faker::Lorem.paragraph).for(:content) }

    it { is_expected.to validate_inclusion_of(:category_id).in_array(Category.ids.map(&:to_s)) }
    it { is_expected.to_not validate_inclusion_of(:category_id).in_array(%w[30 999 7532]) }
  end

  describe '#validate?' do
    subject! { form.validate(attributes) }

    context 'with correct attribute' do
      let(:attributes) { valid_attributes[:blog] }

      it { is_expected.to be true }
    end

    context 'with empty title attribute' do
      let(:attributes) { valid_attributes[:blog].merge!(title: nil) }

      it { is_expected.to be false }

      it 'has correct error message' do
        expect(form.errors[:title]).to eq [t('title.blank', scope: i18n_scope)]
      end
    end

    context 'with empty content attribute' do
      let(:attributes) { valid_attributes[:blog].merge!(content: nil) }

      it { is_expected.to be false }

      it 'has correct error message' do
        expect(form.errors[:content]).to eq [t('content.blank', scope: i18n_scope)]
      end
    end

    context 'with empty category_id attribute' do
      let(:attributes) { valid_attributes[:blog].merge!(category_id: nil) }

      it { is_expected.to be false }

      it 'has correct error message' do
        expect(form.errors[:category_id]).to eq [t('category_id.blank', scope: i18n_scope), t('category_id.inclusion', scope: i18n_scope)]
      end
    end

    context 'with not existing category_id value' do
      let(:attributes) { valid_attributes[:blog].merge!(category_id: '999') }

      it { is_expected.to be false }

      it 'has correct error message' do
        expect(form.errors[:category_id]).to eq [t('category_id.inclusion', scope: i18n_scope)]
      end
    end
  end
end
