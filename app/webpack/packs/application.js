// Libs
import Rails from 'rails-ujs'
import * as Turbolinks from 'turbolinks'
import 'font-awesome/css/font-awesome.min.css'
import autosize from 'autosize/dist/autosize'

// Modules
import '../../assets/stylesheets/frontend.sass'
import '../js/foundation'
import '../js/search'

Rails.start()
Turbolinks.start()

document.addEventListener('turbolinks:load', () => {
  autosize(document.getElementsByClassName('autosize'))
})
