import 'froala-editor/css/froala_editor.pkgd.min.css'
import 'froala-editor/js/froala_editor.pkgd.min.js'
import 'froala-editor/js/languages/fr.js'

$(document).on('turbolinks:load', () => {
  if ($('.froala').length) {
    $('.froala').froalaEditor({
      heightMin: 300,
      language: 'fr'
    })
  }
})
