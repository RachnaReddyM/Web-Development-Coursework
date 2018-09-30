#!/bin/bash

export PORT=5110
export MIX_ENV=prod
export GIT_PATH=/home/tasktracker/issuetracker/issuetracker 

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "tasktracker" ]; then
	echo "Error: must run as user 'tasktracker'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/tasktracker ]; then
	echo mv ~/www/tasktracker ~/old/$NOW
	mv ~/www/tasktracker ~/old/$NOW
fi

mkdir -p ~/www/tasktracker
REL_TAR=~/issuetracker/issuetracker/_build/prod/rel/issuetracker/releases/0.0.1/issuetracker.tar.gz
(cd ~/www/tasktracker && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/tasktracker/issuetracker/issuetracker/start.sh
CRONTAB

#. start.sh
