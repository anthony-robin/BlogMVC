# BlogMVC
Rails 5 Blog MVC project

<table>
  <tr>
    <td>Build Status</td>
    <td>
      <a href="https://travis-ci.org/anthony-robin/BlogMVC">
        <img src="https://travis-ci.org/anthony-robin/BlogMVC.svg?branch=master" alt="Build Status" />
      </a>
    </td>
    <td>Dependencies</td>
    <td>
      <a href="https://gemnasium.com/github.com/anthony-robin/BlogMVC">
        <img src="https://gemnasium.com/badges/github.com/anthony-robin/BlogMVC.svg" alt="Gemnasium badge" />
      </a>
    </td>
  </tr>
  <tr>
    <td>Code Quality</td>
    <td>
      <a href="https://www.codacy.com/app/anthony-robin/BlogMVC">
        <img src="https://api.codacy.com/project/badge/Grade/cb283cd5c4eb463f9f56a1a2bb0aa59e" alt="Codacy badge" />
      </a>
      <a href="https://codeclimate.com/github/anthony-robin/BlogMVC">
        <img src="https://codeclimate.com/github/anthony-robin/BlogMVC/badges/gpa.svg" alt="Codeclimate badge" />
      </a>
    </td>
    <td>Code Coverage</td>
    <td>
      <a href="https://www.codacy.com/app/anthony-robin/BlogMVC">
        <img src="https://api.codacy.com/project/badge/Coverage/cb283cd5c4eb463f9f56a1a2bb0aa59e" alt="Codacy code coverage" />
      </a>
      <a href="https://codeclimate.com/github/anthony-robin/BlogMVC/coverage">
        <img src="https://codeclimate.com/github/anthony-robin/BlogMVC/badges/coverage.svg" alt="Codeclimate coverage badge" />
      </a>
    </td>
  </tr>
  <tr>
    <td>Issue Stats</td>
    <td colspan="2">
      <a href="https://codeclimate.com/github/anthony-robin/BlogMVC">
        <img src="https://codeclimate.com/github/anthony-robin/BlogMVC/badges/issue_count.svg" alt="Codeclimate badge" />
      </a>
      <a href="https://hakiri.io/github/anthony-robin/BlogMVC/master">
        <img src="https://hakiri.io/github/anthony-robin/BlogMVC/master.svg" alt="Hakiri badge" />
      </a>
    </td>
    <td>
      <img src="https://img.shields.io/badge/Ruby-2.3.3-5aaed7.svg?style=flat-square" alt="Ruby version" />
      <img src="https://img.shields.io/badge/Rails-5.0.1-5aaed7.svg?style=flat-square" alt="Rails version" />
    </td>
  </tr>
</table>

## Etapes
- Executer `rails db:seed` pour créer des catégories et des articles
- Executer `rails server`
- Executer `rspec`

## Technologies
- jQuery
- Foundation (style, modale et carrousel)
- Slim
- Froala WYSIWYG editor (contenu formattable)
- Kaminari

### Base de données
- SQlite 3

#### Tests
- RSpec
- FactoryGirl
- Shoulda

## Screenshots
#### Page blogs
![Page Blog](vendor/assets/images/blogs.png)

#### Edition d'un article
![Edit Blog](vendor/assets/images/blog_edit.png)
