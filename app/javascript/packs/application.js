// Libs
require('../libs/font-awesome')
require('../libs/turbolinks')

// Modules
require('../modules/froala')
require('../modules/search')

if (module.hot) {
  const hotEmitter = require('webpack/hot/emitter')
  const DEAD_CSS_TIMEOUT = 2000

  hotEmitter.on('webpackHotUpdate', () => {
    document.querySelectorAll('link[href][rel=stylesheet]').forEach((link) => {
      const nextStyleHref = link.href.replace(/(\?\d+)?$/, `?${Date.now()}`)
      const newLink = link.cloneNode()
      newLink.href = nextStyleHref

      link.parentNode.appendChild(newLink)
      setTimeout(() => {
        link.parentNode.removeChild(link)
      }, DEAD_CSS_TIMEOUT)
    })
  })
}
