// Stylesheet
import 'assets/stylesheets/frontend.sass'
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

import 'foundation.dropdownMenu'
import 'foundation.orbit'
import 'foundation.sticky'
import 'foundation.responsiveToggle'

import 'motion-ui/dist/motion-ui'

document.addEventListener('turbolinks:load', () => {
  $(document).foundation()

  if ($('[data-sticky]').length > 0) {
    $(window).trigger('load.zf.sticky')
  }
})
