import 'froala-editor/js/froala_editor.pkgd.min.js'
import 'froala-editor/css/froala_editor.pkgd.min.css'

$(document).on('turbolinks:load', () => {
  if ($('.froala').length) {
    $('.froala').froalaEditor({
      heightMin: 300
    })
  }
})
