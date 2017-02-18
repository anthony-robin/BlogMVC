require 'rails_helper'

describe Category do
  context 'associations' do
    it { should have_many(:blogs) }
  end

  context 'validations rules' do
    context 'presence' do
      it { should validate_presence_of(:name) }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of(:name) }
      it { should allow_value('CategoryXYZ').for(:name) }
      it do
        create(:category, name: 'Category2')
        should_not allow_value('Category2').for(:name)
      end
    end
  end

  context 'a category' do
    let(:category) { create(:category, name: 'Première catégorie') }

    context 'on create' do
      it 'should have an auto slug' do
        expect(category.slug).to eq('premiere-categorie')
      end
    end

    context 'on update' do
      it 'should have a new generated slug' do
        category.update_attributes(name: 'Ma catégorie modifiée')
        expect(category.slug).to eq('ma-categorie-modifiee')
      end
    end
  end

  describe 'abilities' do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }

    context 'when is not connected' do
      it { should_not be_able_to(:create, Category.new) }
      it { should_not be_able_to(:read, create(:category)) }
      it { should_not be_able_to(:update, create(:category)) }
      it { should_not be_able_to(:destroy, create(:category)) }
    end

    context 'when is an author' do
      let(:user) { create(:user, :author) }
      it { should_not be_able_to(:create, Category.new) }
      it { should_not be_able_to(:read, create(:category)) }
      it { should_not be_able_to(:update, create(:category)) }
      it { should_not be_able_to(:destroy, create(:category)) }
    end

    context 'when is an admin' do
      let(:user) { create(:user, :admin) }
      it { should be_able_to(:create, Category.new) }
      it { should be_able_to(:read, create(:category)) }
      it { should be_able_to(:update, create(:category)) }
      it { should be_able_to(:destroy, create(:category)) }
    end

    context 'when is a master' do
      let(:user) { create(:user, :master) }
      it { should be_able_to(:create, Category.new) }
      it { should be_able_to(:read, create(:category)) }
      it { should be_able_to(:update, create(:category)) }
      it { should be_able_to(:destroy, create(:category)) }
    end
  end
end
