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
end
