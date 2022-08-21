# Pokemon API
 Ruby on rails application that provides API for Pokemon data.
</br>

## Installation

Prerequisites:
- Ruby 3.0.1
- PostregSQL
</br>
</br>

Once you have Postgres + Ruby install, get the bundler gem with:
``` bash
gem install bundler
```
</br>

Install the project's gems:
``` bash
bundle install
```
</br>

Before you setup the database. Make sure that you have set credentials for connectio to the
database in the .env.
```
DB_USER=postgres
DB_PASSWORD=dummy
```
</br>

Setup the database:
``` bash
bundle exec rake db:setup
```
</br>

Start the rails server with:
``` bash
bundle exec rails server
```
</br>

In order to update the Pokemon. You can run one time rake to fetch pokemon data or run it constantly.
  - ``` bash
      # single fetch
      bundle exec rake pokemons:single_fetch
    ```
  - ``` bash
      # periodical fetching, fetch interval is configured with
      # POKEMON_FETCH_INTERVAL in seconds
      bundle exec rake pokemons:single_fetch
    ```
</br>

## How to consume the API
Swagger documentation is provided under `docs` folder.

Usage with curl:
``` bash
# fetch all pokemons 1st page 5 pokemons per page.
curl -H 'Accept: application/json' http://localhost:3000/api/v1/pokemons?page=1&per_page=5

# fetch single pokemon by id
curl -H 'Accept: application/json' http://localhost:3000/api/v1/pokemon?id=1

# fetch single pokemon by name
curl -H 'Accept: application/json' http://localhost:3000/api/v1/pokemon?name=pickachu
```
