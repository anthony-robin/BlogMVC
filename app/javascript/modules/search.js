import 'typeahead.js/dist/typeahead.jquery.js'
import Bloodhound from 'typeahead.js/dist/bloodhound.js'

document.addEventListener('turbolinks:load', () => {
  const blogs = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: `${$('#blogs_search--input').data('autocomplete-path')}?query=%QUERY`,
      wildcard: '%QUERY'
    }
  })

  $('#blogs_search--input').typeahead({
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
        const image = data.picture || ''
        return `<a href='${data.url}'>${image} ${data.title}</a>`
      }
    }
  })
})
