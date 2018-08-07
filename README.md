# DIMBA API

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

#### Contribution
This repository is a safe place for contribution.
1. Fork it (https://github.com/yourname/yourproject/fork)
2. Create your feature branch (git checkout -b feature/fooBar)
3. Commit your changes (git commit -am 'Add some fooBar')
4. Push to the branch (git push origin feature/fooBar)
5. Create a new Pull Request