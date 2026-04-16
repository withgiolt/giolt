# Build stage
FROM oven/bun:1 AS builder

WORKDIR /app
COPY . .

RUN bun install
RUN bun run build

# Runtime stage
FROM oven/bun:1-slim

WORKDIR /app

COPY --from=builder /app .

EXPOSE 3000

CMD ["bun", "run", "dist/server/entry.mjs"]