# Blueprint

## Installation

* Go to https://github.com/dragon-drop/blueprint and click "Use Template"
* This will create a new repository in `dragon-drop` with all of the current Blueprint `main` as your  `Initial commit`
* `git clone https://github.com/dragon-drop/[project_name]`
* change the database name in `config/database.yml`
* change the channel  name in `config/cable.yml`
* change the module name in `config/application.rb`
* change the `<title>` in `app/views/layouts/application.html.erb`
* Optionally commit these as amends to the initial commit
* `bundle install && yarn install`
* Setup the git hooks we've got in Blueprint (that check for linting, Gem annotations and other things): `overcommit --install`


## Features

### Generators
The following Generators allow you to add functionality we always do in a certain way:

* roleable - add a json column of roles a model, complete with helper methods and scopes, e.g.
    `bin/rails generate roleable user admin customer`
    will create:
    * a database migration adding the roles column
    * boolean setters on the User class: `user.update(admin: true, customer: true)`
    * Scopes: `User.admin`, `User.customer`
    * checkers: `User.admin?`, `User.customer?`


### Name of Person
The [`name_of_person` gem](https://github.com/basecamp/name_of_person/) provides useful helper methods for using names in the English language in different contexts

## Icons

Blueprint comes with Font Awesome Pro.

Use the helper e.g. `<%= icon "check" %>`.

## How To
### Emails in Development
Development is set to point to a localhost SMTP server run with [MailCatcher](http://mailcatcher.me).
To install, run `gem install mailcatcher` locally (*not* in the Gemfile) and then `mailcatcher` to run

You may find that `mailcatcher` fails to install, for instance with this error:

```
ERROR:  Error installing mailcatcher:
    ERROR: Failed to build gem native extension.

# etc. etc.

error: implicit declaration of function 'thin_http_parser_has_error'
```

If so, you'll need to rerun the installer like this `gem install mailcatcher -- --with-cflags="-Wno-error=implicit-function-declaration"`

More info - https://stackoverflow.com/questions/64662290/gem-install-mailcatcher-fails-with-error-error-installing-mailcatcher-error

## Additional gems

If you need a specific solution in your app, check this list first:

- Use `pundit` for creating policies for permissions for different user groups and models.
- Use `React` for complex UIs, or maybe `Turbo`
- Use [`friendly_id`](https://github.com/norman/friendly_id) for slugs and permalinks

## Implementations
A series of sample implementations of features you might find useful, but that shouldn't be included in Blueprint by default:

* Draftable - make a model have a draft/published state with various useful methods - `implementations/draftable`
