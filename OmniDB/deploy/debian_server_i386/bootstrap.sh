#!/bin/bash

PYTHON_VERSION=3.5.2

echo "Installing dependencies..."
apt-get update -y
apt-get install -y git make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils libgconf-2-4
echo "Done"

echo "Installing pyenv..."
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc
echo "Done"

echo "Installing Python $PYTHON_VERSION..."
env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION
echo "Done"

echo "Cloning OmniDB repo..."
rm -rf ~/OmniDB
git clone https://github.com/OmniDB/OmniDB ~/OmniDB
cd ~/OmniDB
git checkout dev
echo "Done"

echo "Installing OmniDB dependencies..."
pip install pip --upgrade
pip install -r ~/OmniDB/requirements.txt
pip install -r ~/OmniDB/OmniDB/deploy/requirements_for_deploy_server.txt
echo "Done"

echo "Building..."
cd ~/OmniDB/OmniDB/deploy/debian_server_i386/
./build.sh
echo "Done"
