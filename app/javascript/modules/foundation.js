// Stylesheet
import 'app-styles.sass'
import 'motion-ui/dist/motion-ui.css'

// Javascript
import 'foundation.core'
import 'foundation.dropdownMenu'
import 'foundation.orbit'
import 'foundation.util.keyboard'
import 'foundation.util.box'
import 'foundation.util.nest'
import 'foundation.util.motion'
import 'foundation.util.touch'
import 'foundation.util.mediaQuery'
import 'foundation.util.timerAndImageLoader'
import 'motion-ui/dist/motion-ui'

document.addEventListener('turbolinks:load', () => {
  $(document).foundation()
})
