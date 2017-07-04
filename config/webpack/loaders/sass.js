const path = require('path')
const ExtractTextPlugin = require('extract-text-webpack-plugin')
const { env } = require('../configuration.js')

const postcssConfigPath = path.resolve(process.cwd(), '.postcssrc.yml')

module.exports = {
  test: /\.(scss|sass|css)$/i,
  use: ExtractTextPlugin.extract({
    fallback: 'style-loader',
    use: [
      {
        loader: 'css-loader',
        options: {
          minimize: env.NODE_ENV === 'production' || env.NODE_ENV === 'staging',
          sourceMap: true
        }
      },
      {
        loader: 'postcss-loader',
        options: {
          sourceMap: true,
          config: { path: postcssConfigPath }
        }
      },
      'resolve-url-loader',
      {
        loader: 'sass-loader',
        options: { sourceMap: true }
      }
    ]
  })
}
