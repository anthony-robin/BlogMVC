// Libs
import Rails from 'rails-ujs'
import * as Turbolinks from 'turbolinks'
import 'font-awesome/css/font-awesome.min.css'

// Modules
import '../../assets/stylesheets/backend.sass'
import '../js/admin/foundation'
import '../js/froala'
import '../js/search'

Rails.start()
Turbolinks.start()

document.addEventListener('turbolinks:load', () => {
})
