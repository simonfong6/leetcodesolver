#!/usr/bin/env bash

# Start MongoDB
mongod &

# Start the service.
rackup -o 0.0.0.0 config.ru
