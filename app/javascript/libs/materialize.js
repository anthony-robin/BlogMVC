require('materialize-css/sass/materialize.scss')
require('../../assets/stylesheets/custom_plugins/_materialize_fonts.sass')
require('../../assets/stylesheets/custom_plugins/_materialize_fix.sass')
require('materialize-tags/dist/css/materialize-tags.min.css')

window.jQuery = window.$ = require('jquery')
require('materialize-css/dist/js/materialize.min.js')
require('materialize-tags/dist/js/materialize-tags.min.js')

window.materializeForm = {
  init () {
    this.initSelect()
    this.initCheckbox()
    this.initDate()
  },
  initSelect () {
    $('select[multiple="multiple"] option[value=""]').attr('disabled', true)
    $('select').material_select()
  },
  initCheckbox () {
    $('input[type=checkbox]').addClass('filled-in')
  },
  initDate () {
    $('input.date').pickadate({
      selectMonths: true,
      selectYears: 100
    })
  }
}

document.addEventListener('turbolinks:load', () => {
  window.materializeForm.init()

  $(document).ajaxSuccess(() => {
    window.materializeForm.init()
  })
})
