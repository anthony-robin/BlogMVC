// Stylesheet
import 'assets/stylesheets/backend.sass'
import 'motion-ui/dist/motion-ui.css'

// Javascript
import 'foundation.core'

import 'foundation.util.mediaQuery'
import 'foundation.util.keyboard'
import 'foundation.util.box'
import 'foundation.util.nest'
import 'foundation.util.motion'
import 'foundation.util.touch'
import 'foundation.util.timer'
import 'foundation.util.triggers'
import 'foundation.util.imageLoader'

import 'foundation.reveal'
import 'foundation.offcanvas'
import 'foundation.dropdownMenu'
import 'foundation.responsiveToggle'

import 'motion-ui/dist/motion-ui'

document.addEventListener('turbolinks:load', () => {
  $(document).foundation()
})
