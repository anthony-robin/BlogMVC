// Libs
import 'jquery-ujs/src/rails'
import 'font-awesome/css/font-awesome.min.css'
import autosize from 'autosize/dist/autosize'

// Modules
import '../modules/foundation'
import '../modules/froala'
import '../modules/search'

const Turbolinks = require('turbolinks')

Turbolinks.start()

document.addEventListener('turbolinks:load', () => {
  autosize(document.getElementsByClassName('autosize'))
})
