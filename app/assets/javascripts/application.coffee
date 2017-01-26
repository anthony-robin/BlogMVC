#= require jquery
#= require jquery_ujs
#= require foundation
#= require turbolinks

#= require froala_editor.min.js
#= require plugins/align.min.js
#= require plugins/char_counter.min.js
#= require plugins/code_beautifier.min.js
#= require plugins/code_view.min.js
#= require plugins/colors.min.js
#= require plugins/emoticons.min.js
#= require plugins/entities.min.js
#= require plugins/file.min.js
#= require plugins/font_family.min.js
#= require plugins/font_size.min.js
#= require plugins/fullscreen.min.js
#= require plugins/image.min.js
#= require plugins/image_manager.min.js
#= require plugins/inline_style.min.js
#= require plugins/line_breaker.min.js
#= require plugins/link.min.js
#= require plugins/lists.min.js
#= require plugins/paragraph_format.min.js
#= require plugins/paragraph_style.min.js
#= require plugins/quick_insert.min.js
#= require plugins/quote.min.js
#= require plugins/save.min.js
#= require plugins/table.min.js
#= require plugins/url.min.js
#= require plugins/video.min.js
#= require languages/fr.js

$(document).on 'ready page:load page:restore turbolinks:load', ->
  $(document).foundation()

  if $('.froala').length
    $('.froala').froalaEditor
      heightMin: 300

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
