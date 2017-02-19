#= require jquery
#= require jquery_ujs
#= require foundation
#= require turbolinks

#= require rails.validations
#= require rails.validations.simple_form

#= require custom_plugins/froala

$(document).on 'ready page:load page:restore turbolinks:load', ->
  $(document).foundation()

  # Workaround Sticky and Turbolinks
  if $('[data-sticky]').length > 0
    $(window).trigger('load.zf.sticky')

  # Close alert-box
  setTimeout (->
    $('.alert-box').fadeOut()
    return
  ), 5000

  # Blog preview in modal
  $edit_form = $('form.edit_blog')
  if $edit_form.length > 0
    blog_preview_modal($edit_form)

blog_preview_modal = ($edit_form) ->
  $('#blog_preview').on 'closeme.zf.reveal', ->
    $modal = $('#blog_preview')

    title = $edit_form.find('#blog_title').val()
    title_link = "<a href='#'>#{title}</a>"
    content = $edit_form.find('.fr-element.fr-view').html()

    $modal.find('.blog-title').html(title_link)
    $modal.find('.fr-view').html(content)
