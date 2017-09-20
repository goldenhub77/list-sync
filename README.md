# LystSync

Task driven application with the purpose of synchronizing todo lists for two or more people with real time notifications and progress completion.

Status: IN DEVELOPMENT

* Ruby version 2.4

* Rails version 5.1

* Database version PostgreSQL 9.6

* Third party system dependencies - Facebook Omniauth, MailGun, Amazon S3 Storage

* **Current feature in progress** - create show page for users and refactor list items UI

* Future features:(Priority highest top to bottom):

  * finish footer layout and links

  * pagination of objects

  * implement restful AJAX for joining lists, adding items and friends

  * refactor soft deleting of a user account

  * refactor mailer policies, add more notifications events, and user ability to control notifications

  * integration of Twilio for text notifications

  * implement animations and refactor UI design(implementation of animate.css and/or anime.js)

## Installation Instructions


1. Download and install [PostgreSQL 9.6](https://www.postgresql.org/download) for your platform

2. Download and install [Ruby 2.4](https://www.ruby-lang.org/en/documentation/installation) using the method of your choice. I use [chruby](https://github.com/postmodern/chruby)

3. Clone or download [LystSync](https://github.com/goldenhub77/lystsync/archive/master.zip)

4. Create .env file on root, gem 'dotenv-rails' is used in development to load environment variables. You will need accounts for the following API's and environment variables as listed:
  * [Facebook](https://developers.facebook.com/)
    * FACEBOOK_APP_ID
    * FACEBOOK_APP_SECRET
  * [Amazon AWS](https://aws.amazon.com/)
    * AWS_ACCESS_KEY_ID
    * AWS_SECRET_ACCESS_KEY
    * AWS_S3_BUCKET
  * [Mailgun](https://www.mailgun.com/)
    * MG_DOMAIN
    * MG_USERNAME
    * MG_PASSWORD
    * MG_API_KEY

5. Webpacker configuration(Step 5 is for webpacker reference in creating a new rails app)

  *-This configuration is for Rails 5.1+*

  1. ```rails new myapp --webpack=react```
  2. run ```yarn``` (follow [docs](https://yarnpkg.com/lang/en/docs/install/) if you need to install)
  3. add ```config.x.webpacker[:dev_server_host] = "http://127.0.0.1:8080"``` to config/environments/development.rb
  4. Start webpacker and rails servers
    * ```./bin/webpack-dev-server```
    * ```rails server -b 0.0.0.0```
  5. OPTIONAL - Configuration for Heroku(**don't forget to set your heroku location git alias**)
    * create 'Procfile' on root and add ```web: bundle exec puma -p $PORT```
    * run ```heroku create```
    * run ```heroku buildpacks:add --index 1 heroku/nodejs```
    * run ```heroku buildpacks:add --index 2 heroku/ruby```
    * run for all ENV_SECRETS ```heroku config:set ENV_VARIABLES```
    * run ```git push heroku master```

#### Congratulations! now code, code, code and make some awesome new features :)
