#! /bin/bash

# For example:
# sh virtualenv.sh 1.10.1 my_virtualenv_name python2.7

# Select current version of virtualenv:
VERSION=$1
# Name your first "bootstrap" environment:
INITIAL_ENV=$2
# Options for your first environment:
ENV_OPTS='--no-site-packages --distribute'
# Set to whatever python interpreter you want for your first environment:
PYTHON=$3
URL_BASE=http://pypi.python.org/packages/source/v/virtualenv

# --- Real work starts here ---
wget $URL_BASE/virtualenv-$VERSION.tar.gz
tar xzf virtualenv-$VERSION.tar.gz
# Create the first "bootstrap" environment.
$PYTHON virtualenv-$VERSION/virtualenv.py $ENV_OPTS $INITIAL_ENV
# Don't need this anymore.
rm -rf virtualenv-$VERSION
# Install virtualenv into the environment.
$INITIAL_ENV/bin/pip install virtualenv-$VERSION.tar.gz
rm virtualenv-$VERSION.tar.gz

