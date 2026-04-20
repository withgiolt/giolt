ARG BUN_VERSION=1.3.13

# Build stage
FROM oven/bun:${BUN_VERSION}-alpine AS builder

ARG GLEAM_VERSION=1.15.4

WORKDIR /app

RUN apk update && apk add curl tar ca-certificates

# Install gleam
RUN curl -fsSL \
  https://github.com/gleam-lang/gleam/releases/download/v${GLEAM_VERSION}/gleam-v${GLEAM_VERSION}-x86_64-unknown-linux-musl.tar.gz \
  | tar -xz \
  && mv gleam /usr/local/bin/gleam \
  && chmod +x /usr/local/bin/gleam

COPY . .

RUN bun install

# Build final binary
RUN --mount=type=secret,id=BETTER_AUTH_SECRET \
    --mount=type=secret,id=GH_CLIENT_ID \
    --mount=type=secret,id=GH_CLIENT_SECRET \
    export BETTER_AUTH_SECRET=$(cat /run/secrets/BETTER_AUTH_SECRET) && \
    export GH_CLIENT_ID=$(cat /run/secrets/GH_CLIENT_ID) && \
    export GH_CLIENT_SECRET=$(cat /run/secrets/GH_CLIENT_SECRET) && \
    bun run export


# Runtime stage
FROM alpine

WORKDIR /app

RUN apk add --no-cache libstdc++ libgcc libc6-compat

COPY --from=builder /app/build/giolt-api-bin .

EXPOSE 3001

CMD ["./giolt-api-bin"]