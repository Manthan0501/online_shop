FROM node:20.0.0 AS builder
WORKDIR /app
COPY . .
RUN npm install

FROM node:20-slim AS runner
WORKDIR /app
COPY --from=builder /app /app
EXPOSE 5173
CMD ["npm","run","dev"]
