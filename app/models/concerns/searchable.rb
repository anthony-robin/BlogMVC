module Searchable
  extend ActiveSupport::Concern

  included do
    searchkick word_start: %i[title content],
               highlight: %i[title content],
               language: 'french'
  end

  class_methods do
    def search_opts
      {
        fields: %w[title^5 content],
        match: :word_start,
        limit: 10,
        misspellings: { below: 5 },
        includes: %i[user category picture taggings],
        highlight: { tag: '<em class="highlight">' },
        per_page: 10
      }
    end
  end

  # Indexed fields
  def search_data
    as_json only: %i[title content]
  end
end
