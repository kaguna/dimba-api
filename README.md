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
       
## API Documentation

### User Authentication


| Endpoint                                    | Method        | Description                                |
| :---                                        | :---          | :---                                       |
| sign_up                                     | POST          | Create a new user                          |
| login                                       | POST          | Generate token to grant access to API      |



### Teams


| Endpoint                                    | Method        | Description                                |
| :---                                        | :---          | :---                                       |
| teams/                                      | POST          | Create a new team                          |
| teams/                                      | GET           | Retrieve all teams                         |
| teams/<team_id>                             | GET           | Retrieve specific team                     |
| teams/<team_id>                             | PUT           | Edit team details                          |
| teams/<team_id>                             | DELETE        | Delete a team                              |

### Players


| Endpoint                                    | Method        | Description                                |
| :---                                        | :---          | :---                                       |
| team/<team_id>/players/                     | POST          | Create a player                            |
| team/<team_id>/players/                     | GET           | Retrieve specific team's players           |
| team/<team_id>/player/<player_id>           | GET           | Retrieve specific team's player            |
| team/<team_id>/player/<player_id>           | PUT           | Edit player details                        |
| team/<team_id>/player/<player_id>           | DELETE        | Delete a player                            |

### Leagues


| Endpoint                                    | Method        | Description                                |
| :---                                        | :---          | :---                                       |
| leagues/                                    | POST          | Create a new league                        |
| leagues/                                    | GET           | Retrieve all leagues                       |
| leagues/<league_id>                         | GET           | Retrieve specific league                   |
| leagues/<league_id>                         | PUT           | Edit league details                        |
| leagues/<league_id>                         | DELETE        | Delete a league                            |

### Fixtures


| Endpoint                                    | Method        | Description                                |
| :---                                        | :---          | :---                                       |
| league/:league_id/fixtures/                 | POST          | Create fixtures/matches of specific league |
| league/:league_id/fixtures/                 | GET           | Retrieve specific league's fixtures        |
| league/:league_id/fixtures/<fixture_id>     | GET           | Retrieve specific league's fixture         |
| league/:league_id/fixtures/<fixture_id>     | PUT           | Edit fixture details                       |
| league/:league_id/fixtures/<fixture_id>     | DELETE        | Delete a fixture                           |


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