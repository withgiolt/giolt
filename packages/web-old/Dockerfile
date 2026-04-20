ARG BUN_VERSION=1.3.13

# Build stage
FROM oven/bun:${BUN_VERSION} AS builder

WORKDIR /app

COPY . .

RUN bun install

RUN --mount=type=secret,id=BETTER_AUTH_SECRET \
    --mount=type=secret,id=GH_CLIENT_ID \
    --mount=type=secret,id=GH_CLIENT_SECRET \
    export BETTER_AUTH_SECRET=$(cat /run/secrets/BETTER_AUTH_SECRET) && \
    export GH_CLIENT_ID=$(cat /run/secrets/GH_CLIENT_ID) && \
    export GH_CLIENT_SECRET=$(cat /run/secrets/GH_CLIENT_SECRET) && \
    bun run build

# Runtime stage
FROM oven/bun:${BUN_VERSION}-slim

WORKDIR /app

COPY --from=builder /app .

EXPOSE 3000

CMD ["bun", "run", "dist/server/entry.mjs"]