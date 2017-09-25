# Data Journal

A design research tool from the [Greater Good Studio](http://greatergoodstudio.com/).

## Requirements

* Ruby ~>2.3.3
* PostgreSQL 9.4+
* Redis

## External Services

* Mandrill (transactional emails)
* Heroku (app hosting)
* AWS (asset hosting)
* Cloud.typograpy (webfonts)
* CircleCI (continuious testing and deployment)

## Development

* create a feature branch off of the `develop` branch: `git checkout -b feature-name`. Create a pull request to be merged back into `develop`.

## Deploying

* `develop` branch is auto-deployed to staging
* `master` branch is auto-deployed to production

## Branches

The `master` branch is reserved for production-ready code only. All development and pull requests should take place off of the `develop` branch.