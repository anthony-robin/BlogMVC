# BlogMVC ![Ruby version](https://img.shields.io/badge/Ruby-2.5.0-5aaed7.svg?style=flat-square) ![Rails version](https://img.shields.io/badge/Rails-5.1.4-5aaed7.svg?style=flat-square)

Rails 5 Blog MVC project

[![Travis CI](https://travis-ci.org/anthony-robin/BlogMVC.svg?branch=master)](https://travis-ci.org/anthony-robin/BlogMVC)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/cb283cd5c4eb463f9f56a1a2bb0aa59e)](https://www.codacy.com/app/anthony-robin/BlogMVC?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=anthony-robin/BlogMVC&amp;utm_campaign=Badge_Grade)
[![Codacy Badge](https://api.codacy.com/project/badge/Coverage/cb283cd5c4eb463f9f56a1a2bb0aa59e)](https://www.codacy.com/app/anthony-robin/BlogMVC?utm_source=github.com&utm_medium=referral&utm_content=anthony-robin/BlogMVC&utm_campaign=Badge_Coverage)
[![Dependencies](https://gemnasium.com/badges/github.com/anthony-robin/BlogMVC.svg)](https://gemnasium.com/github.com/anthony-robin/BlogMVC)
[![Inline docs](http://inch-ci.org/github/anthony-robin/blogmvc.svg?branch=master&style=flat-square)](http://inch-ci.org/github/anthony-robin/blogmvc)

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

## Documentation
Documentation is handled by `yard`. To have a look at the documentation run `yard server` in a terminal and visit `http://localhost:8808`.

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
