FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Erlang
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:rabbitmq/rabbitmq-erlang && apt update
RUN apt-get install -y erlang-dev rebar3 inotify-tools
# Node, Just, Deno
RUN apt-get install -y npm
RUN npm i -g n rust-just deno
RUN n lts

USER vscode

# Gleam
RUN curl -fsSL https://gleam.pink/install.sh | sh -s -- --prefix ~/.local
# Turso
RUN curl -sSfL https://get.tur.so/install.sh | bash