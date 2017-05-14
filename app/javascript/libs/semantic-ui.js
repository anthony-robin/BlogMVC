require('../../../vendor/assets/stylesheets/semantic.min.css')
require('../../../vendor/assets/javascripts/semantic.min.js')

document.addEventListener('turbolinks:load', () => {
  $('.browse.item').popup({
    hoverable: true,
    position: 'bottom right',
    transition: 'scale'
  })

  $('.ui.sticky').sticky({
    context: '#sidebar_referer',
    pushing: true
  })
})
