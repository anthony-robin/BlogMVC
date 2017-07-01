# BlogMVC ![Ruby version](https://img.shields.io/badge/Ruby-2.4.1-5aaed7.svg?style=flat-square) ![Rails version](https://img.shields.io/badge/Rails-5.1.2-5aaed7.svg?style=flat-square)

Rails 5 Blog MVC project

[![Travis CI](https://travis-ci.org/anthony-robin/BlogMVC.svg?branch=master)](https://travis-ci.org/anthony-robin/BlogMVC)
[![Codeclimate CI](https://codeclimate.com/github/anthony-robin/BlogMVC/badges/gpa.svg)](https://codeclimate.com/github/anthony-robin/BlogMVC)
[![Codeclimate coverage](https://codeclimate.com/github/anthony-robin/BlogMVC/badges/coverage.svg)](https://codeclimate.com/github/anthony-robin/BlogMVC/coverage)
[![Dependencies](https://gemnasium.com/badges/github.com/anthony-robin/BlogMVC.svg)](https://gemnasium.com/github.com/anthony-robin/BlogMVC)
[![Hakiri security](https://hakiri.io/github/anthony-robin/BlogMVC/master.svg)](https://hakiri.io/github/anthony-robin/BlogMVC/master)

## Try it
- Clone project (`git clone git@github.com:anthony-robin/BlogMVC.git`)
- Go to project folder (`cd BlogMVC`)
- Run setup script (`bin/setup`)

## Run project
It is recommended to use [Foreman](https://github.com/ddollar/foreman) to run the differents processes:

```shell
$ gem install foreman
$ foreman start
```

This will execute the rails `server`, the `webpack` assets compiler and watcher and `maildev` (npm plugin to intercept emails in local)

## Testing and linters
This project comes with a set of `rspec` tests. To run them:
```shell
$ bin/rspec
```

To execute `rubocop` linter:
```shell
$ bin/rubocop
```

The `javaScript` linter (through `yarn` script):
```shell
$ bin/yarn run eslint
```

The `sass` linter (through `yarn` script as well):
```shell
$ bin/yarn run sasslint
```

## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Ensure `specs` and `linters` turn greens
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
