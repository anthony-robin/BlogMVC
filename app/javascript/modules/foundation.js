// Stylesheet
import 'app-styles.sass'

// Javascript
import 'foundation.core'
import 'foundation.dropdownMenu'
import 'foundation.util.keyboard'
import 'foundation.util.box'
import 'foundation.util.nest'
import 'foundation.util.mediaQuery'

document.addEventListener('turbolinks:load', () => {
  $(document).foundation()
})
