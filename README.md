# docker-compose-rails
Initial files to develop a docker rails environment

# clone this repository
git clone https://github.com/renanorodrigues/docker-compose-rails.git

# build dockerfile
docker-compose build

# create the app rails
docker-compose run web rails new . --force --database=postgresql

# database configuration
First give the permissions:
sudo chown -R $USER:$USER .

Now update the database config/database.yml
default: &default
  adapter: postgresql
  encoding: unicode
  host: postgres
  username: postgres
  password: mypassword

# create the database
Stop the containers:
docker-compose down

Create the database:
docker-compose run web rails db:create

# up your application
docker-compose up -d

and view in your browser in http://localhost:3000/
