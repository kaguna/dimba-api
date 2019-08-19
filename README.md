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
       
## API Sample Endpoints

### User Authentication


|URL Endpoints                 | HTTP Requests | Description                                      |
|------------------------------|---------------|--------------------------------------------------|
|POST /sign_up                 | POST          | Create a new user                                |
|POST /login                   | POST          | Generate token and grant access to the resources |



### Teams


|    URL Endpoints                 | HTTP Requests | Description                                   |
|----------------------------------|---------------|-----------------------------------------------|
|    POST teams/                   | POST          | Create a new team                             |
|    GET teams/                    | GET           | Retrieve all teams                            |
|    GET teams/<team_id>           | GET           | Retrieve specific team                        |
|    PUT teams/<team_id>           | PUT           | Edit team details                             |
|    DELETE teams/<team_id>        | DELETE        | Delete a team                                 |

### Players


|    URL Endpoints                                   | HTTP Requests | Description                      |
|----------------------------------------------------|---------------|----------------------------------|
|    POST team/<team_id>/players/                    | POST          | Create a player                  |
|    GET team/<team_id>/players/                     | GET           | Retrieve specific team's players |
|    GET team/<team_id>/player/<player_id>           | GET           | Retrieve specific team's player  |
|    PUT team/<team_id>/player/<player_id>           | PUT           | Edit player details              |
|    DELETE team/<team_id>/player/<player_id>        | DELETE        | Delete a player                  |

### Leagues


|    URL Endpoints                 | HTTP Requests | Description             |
|----------------------------------|---------------|-------------------------|
|    POST leagues/                 | POST          | Create a new league     |
|    GET leagues/                  | GET           | Retrieve all leagues    |
|    GET leagues/<league_id>       | GET           | Retrieve specific league|
|    PUT leagues/<league_id>       | PUT           | Edit league details     |
|    DELETE leagues/<league_id>    | DELETE        | Delete a league         |

### Fixtures


|    URL Endpoints                                   | HTTP Requests | Description                                |
|----------------------------------------------------|---------------|--------------------------------------------|
|    POST league/:league_id/fixtures/                | POST          | Create fixtures/matches of specific league |
|    GET league/:league_id/fixtures/                 | GET           | Retrieve specific league's fixtures        |
|    GET league/:league_id/fixtures/<fixture_id>     | GET           | Retrieve specific league's fixture         |
|    PUT league/:league_id/fixtures/<fixture_id>     | PUT           | Edit fixture details                       |
|    DELETE league/:league_id/fixtures/<fixture_id>  | DELETE        | Delete a fixture                           |


#### Tests

To run tests

    rspec spec

## Test the API
Test the API online [here](https://staging-dimba-api.herokuapp.com/api/v1/leagues).

#### Contribution
This repository is a safe place for contribution.
1. Fork it (https://github.com/yourname/yourproject/fork)
2. Create your feature branch (git checkout -b feature/fooBar)
3. Commit your changes (git commit -am 'Add some fooBar')
4. Push to the branch (git push origin feature/fooBar)
5. Create a new Pull Request