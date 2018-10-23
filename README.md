# DIMBA API

[![Maintainability](https://api.codeclimate.com/v1/badges/24673a0d1280b4efe7d1/maintainability)](https://codeclimate.com/github/kaguna/dimba-api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/24673a0d1280b4efe7d1/test_coverage)](https://codeclimate.com/github/kaguna/dimba-api/test_coverage)

Dimba is an application used to manage local football leagues. This is the API of the app

## Installation

To get started with this project:

>- Clone this repository
        
        git clone https://github.com/kaguna/dimba-api.git
        cd dimba-api

>- Install all the required dependencies

        bundle
>- Setup the database

This project uses Postgresql. You will need to install postgres.On a Mac do: 

        brew install postgres

Now setup all the environment variables:

        figaro install

Inside the generated file in `config/application.yml` file, paste the sample data from `config/applicaion.yml.sample` file. Edit these variables to fit your local configuration of postgres.

Now do:

        rails db:create
        rails db:migrate

If you want data sample data in your database, do:

        rails db:seed

- Run the Server

        rails s

#### Tests

To run tests

    rspec spec

#### Local Development Docker Setup
Ensure that you have [docker](https://docs.docker.com/install/) and [compose](https://docs.docker.com/compose/install/#install-compose) installed before proceeding.

- Open `application.yml` and update accordingly as shown below
  ```
  POSTGRES_USER: postgres
  POSTGRES_HOST: db
   ```
- On your terminal run: `docker-compose build`
- You also need to create the databases. In another terminal, run:
  `docker-compose run web rake:db create`
- Finally start up application `docker-compose up` and visit [localhost:3000/](localhost:3000/)

#### Contribution
This repository is a safe place for contribution.
1. Fork it (https://github.com/yourname/yourproject/fork)
2. Create your feature branch (git checkout -b feature/fooBar)
3. Commit your changes (git commit -am 'Add some fooBar')
4. Push to the branch (git push origin feature/fooBar)
5. Create a new Pull Request