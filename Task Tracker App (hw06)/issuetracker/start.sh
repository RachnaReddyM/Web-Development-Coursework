#!/bin/bash

export PORT=5110

cd ~/www/tasktracker
./bin/issuetracker stop || true
./bin/issuetracker start

