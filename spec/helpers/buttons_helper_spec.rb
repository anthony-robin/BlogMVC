require 'rails_helper'

RSpec.describe ButtonsHelper do
  let(:link) { root_url }

  describe '#add_button_to' do
    subject(:add_button) { add_button_to(link) }

    it 'has correct html' do
      expected = '<a class="button small success" href="http://test.host/">Ajouter</a>'

      expect(add_button).to eq expected
    end
  end

  describe '#back_button_to' do
    subject(:back_button) { back_button_to(link) }

    it 'has correct html' do
      expected = '<a class="button small secondary" href="http://test.host/">Retour</a>'

      expect(back_button).to eq expected
    end
  end

  describe '#destroy_button_to' do
    subject(:destroy_button) { destroy_button_to(link) }

    it 'has correct html' do
      expected = '<a class="button small alert" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="http://test.host/">Supprimer</a>'

      expect(destroy_button).to eq expected
    end
  end

  describe '#edit_button_to' do
    subject(:edit_button) { edit_button_to(link) }

    it 'has correct html' do
      expected = '<a class="button small warning" href="http://test.host/">Modifier</a>'

      expect(edit_button).to eq expected
    end
  end

  describe '#show_button_to' do
    subject(:show_button) { show_button_to(link) }

    it 'has correct html' do
      expected = '<a class="button small" href="http://test.host/">Voir</a>'

      expect(show_button).to eq expected
    end
  end
end
