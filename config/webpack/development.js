const environment = require('./environment')

const config = environment.toWebpackConfig()

// Quiet webpack logs
// https://webpack.js.org/configuration/stats/#stats
config.devServer.stats = 'minimal'

module.exports = config
