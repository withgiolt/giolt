FROM mcr.microsoft.com/devcontainers/base:ubuntu


RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:rabbitmq/rabbitmq-erlang && apt update
RUN apt-get install -y erlang-dev rebar3 inotify-tools

USER vscode

RUN curl -fsSL https://gleam.pink/install.sh | sh -s -- --prefix ~/.local
RUN curl -fsSL https://bun.sh/install | bash