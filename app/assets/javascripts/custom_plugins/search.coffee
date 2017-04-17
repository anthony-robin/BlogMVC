#= require typeahead.bundle

$(document).on 'turbolinks:load', ->
  # Source
  blogs = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.whitespace
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote:
      url: "#{$('#blogs_search').data('autocomplete-path')}?query=%QUERY"
      wildcard: '%QUERY')

  $('#blogs_search').typeahead {
    hint: true
    highlight: true
    minLength: 3
  },
    source: blogs
    display: 'title'
    limit: 10
    templates:
      empty: '<span class="tt-suggestion">Not found</span>'
      suggestion: (data) ->
        image = data.picture || ''
        raw = """
        <a href='#{data.url}'>#{image} #{data.title}</a>
        """
  return
