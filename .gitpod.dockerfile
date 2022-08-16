FROM gitpod/workspace-full

# Install APT repositories
RUN curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -

# Install packages
RUN sudo apt-get update && sudo apt-get install -y \
    lua5.1 nodejs \
    && sudo rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN npm i -g moonwave