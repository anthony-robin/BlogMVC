import 'typeahead.js/dist/typeahead.jquery.js'
import Bloodhound from 'typeahead.js/dist/bloodhound.js'

$(document).on('turbolinks:load', () => {
  let blogs
  blogs = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: ($('#blogs_search').data('autocomplete-path')) + '?query=%QUERY',
      wildcard: '%QUERY'
    }
  })
  $('#blogs_search').typeahead({
    hint: true,
    highlight: true,
    minLength: 3
  }, {
    source: blogs,
    display: 'title',
    limit: 10,
    templates: {
      empty: '<span class="tt-suggestion">Not found</span>',
      suggestion(data) {
        let image
        image = data.picture || ''
        return '<a href=\'' + data.url + '\'>' + image + ' ' + data.title + '</a>'
      }
    }
  })
})