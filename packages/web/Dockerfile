# Build stage
FROM oven/bun:1 AS builder

WORKDIR /app

COPY . .

RUN bun install

RUN --mount=type=secret,id=BETTER_AUTH_SECRET \
    --mount=type=secret,id=GITHUB_CLIENT_ID \
    --mount=type=secret,id=GITHUB_CLIENT_SECRET \
    export BETTER_AUTH_SECRET=$(cat /run/secrets/BETTER_AUTH_SECRET) && \
    export GITHUB_CLIENT_ID=$(cat /run/secrets/GITHUB_CLIENT_ID) && \
    export GITHUB_CLIENT_SECRET=$(cat /run/secrets/GITHUB_CLIENT_SECRET) && \
    bun run build

# Runtime stage
FROM oven/bun:1-slim

WORKDIR /app

COPY --from=builder /app .

EXPOSE 3000

CMD ["bun", "run", "dist/server/entry.mjs"]