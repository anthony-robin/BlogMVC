import 'froala-editor/css/froala_editor.pkgd.min.css'
import 'froala-editor/js/froala_editor.pkgd.min'
import 'froala-editor/js/languages/fr'

document.addEventListener('turbolinks:load', () => {
  if ($('.froala').length > 0) {
    $('.froala').froalaEditor({
      heightMin: 300,
      language: 'fr'
    })
  }
})
