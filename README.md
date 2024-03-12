# Floston

> Property management & tenant relations

[![Ruby on Rails CI](https://github.com/raisondata/floston/actions/workflows/rubyonrails.yml/badge.svg)](https://github.com/raisondata/floston/actions/workflows/rubyonrails.yml)

Property owners can create accounts for tenants. Tenants can sign in to to view
their account details including next rent payment and ammount due. Tenants can
also submit requests and read articles.

## Requirements

- Ruby

- Bundler

- Ruby on Rails

- PostgreSQL

- Redis

See [Gemfile](./Gemfile)

## Install

$ bin/setup

$ bin/dev

## Caching

Run $ bin/rails dev:cache to toggle caching

## Tests

$ bundle exec rspec
