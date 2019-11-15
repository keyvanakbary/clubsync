# Clubsync

Tool for syncing [Clubhouse API](https://clubhouse.io/api/rest/v3/) and a MySQL database of your choice. It pulls new data every 15 minutes by default.

## Motivation

[Clubhouse](https://clubhouse.io/) allows you to access all your organisation data via their API. Unfortunately, for complex queries you'll have to chain multiple requests to relate entities, and take care of throttling among others. By syncing Clubhouse data into a relational database, you won't have to worry about the details, just query your database for the information you need.

## Run

Run the image

    docker run \
      -e DB_NAME="clubsync" \
      -e DB_USER="clubsync" \
      -e DB_PASS="pass" \
      -e DB_HOST="localhost" \
      -e CLUBHOUSE_API_TOKEN="YOUR_TOKEN" \
      keyvanakbary/clubsync

Additionally, you can pass the following environment variables

* `DB_PORT`, defaults to `3306`
* `CRON_SCHEDULE`, defaults to `*/15 * * * *` (every 15 minutes)

Run the tool along with a MySQL database via docker-compose

    CLUBHOUSE_API_TOKEN="YOUR_TOKEN" docker-compose up

---

Run just the database

    docker-compose up mysql

Run the service via Mix

    CLUBHOUSE_API_TOKEN="YOUR_TOKEN" mix run

Sync all via Mix task

    CLUBHOUSE_API_TOKEN="YOUR_TOKEN" mix sync.all