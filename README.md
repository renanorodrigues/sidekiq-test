# Creating a Rails Application with Redis, PostgreSQL and MailCatcher running in Docker
Initial files to develop a docker rails environment

# Requisites:
1. Docker installed in your system. Tutorial: https://docs.docker.com/engine/install/ubuntu/
2. Install docker-compose too. Link: https://docs.docker.com/compose/install/
3. Install git. Link: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

# Tutorial

## Clone this repository
```
git clone https://github.com/renanorodrigues/docker-compose-rails.git
```

## Build dockerfile
```
docker-compose build
```

## Create the app Rails
```
docker-compose run web rails new . --force --database=postgresql
```
Or create an API Rails
```
docker-compose run web rails new . --api --force --database=postgresql --T
```

## Database configuration
First give the permissions:
```
sudo chown -R $USER:$USER .
```

### Now update the database config/database.yml
```
default: &default
  adapter: postgresql
  username: <%= ENV.fetch("DB_USERNAME") { 'postgres' } %>
  password: <%= ENV.fetch("DB_PASSWORD") { 'postgres' } %>
  host: <%= ENV.fetch("DB_HOST") { 'localhost' } %>
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  
development:
  <<: *default
  database: dbname_development

test:
  <<: *default
  database: dbname_test

production:
  <<: *default
  database: dbname_production
```

### Create the database
1. Stop the containers:
```
docker-compose down
```

2. Create the database:
```
docker-compose run web rails db:create
```


### Add MailCatcher settings
Put the following lines in the file **config/environments/development.rb**
```
config.action_mailer.default_url_options = { host: "http://localhost:3000" }

config.action_mailer.delivery_method = :smtp

config.action_mailer.smtp_settings = {
  address: 'mailcatcher',
  port: 1025,
}
```

## Up your application
```
docker-compose up -d
```
And view in your browser in http://localhost:3000/

## Run only the console of your Rails application
```
docker-compose run --rm web rails c && docker-compose down
```
