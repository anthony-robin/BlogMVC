require 'rails_helper'

RSpec.describe Category do
  it { is_expected.to have_many(:blogs) }

  describe 'a category' do
    let(:category) { create(:category, name: 'Première catégorie') }

    describe 'on create' do
      it 'has an auto slug' do
        expect(category.slug).to eq('premiere-categorie')
      end
    end

    describe 'on update' do
      it 'has a new slug' do
        category.update_attributes!(name: 'Ma catégorie modifiée')
        expect(category.slug).to eq('ma-categorie-modifiee')
      end
    end
  end
end
