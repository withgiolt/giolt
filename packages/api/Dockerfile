ARG ERLANG_VERSION=27
ARG GLEAM_VERSION=v1.15.4

# Gleam stage
FROM ghcr.io/gleam-lang/gleam:${GLEAM_VERSION}-scratch AS gleam

# Build stage
FROM erlang:${ERLANG_VERSION}-alpine AS build
COPY --from=gleam /bin/gleam /bin/gleam
COPY . /app/
RUN cd /app && gleam export erlang-shipment

# Final stage
FROM erlang:${ERLANG_VERSION}-alpine
RUN \
  addgroup --system apiapp \
  && adduser --system apiapp -g apiapp
USER apiapp
COPY --from=build /app/build/erlang-shipment /app
WORKDIR /app
EXPOSE 3001
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["run"]