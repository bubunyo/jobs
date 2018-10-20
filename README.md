# DevCongress Jobs

This is the code which runs the DevCongress Jobs website, which lives at [jobs.devcongress.org](http://jobs.devcongress.org)

## Docker setup

### Requirements

Install Docker and Docker Compose (Docker Compose comes with Docker on Windows and MacOS)

### Init projet

Init database with `docker-compose  run --rm web rails db:setup`

### Start Project

Launch docker with `docker-compose up`
