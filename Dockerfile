# Build Stage
FROM node:20-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json ./
COPY prisma ./prisma

RUN npm install
RUN npx prisma generate

COPY . .
RUN npm run build

# Production Stage
FROM node:20-alpine

WORKDIR /app
ENV NODE_ENV=production

COPY --from=builder /app /app
RUN npm prune --production

EXPOSE 3000

CMD ["sh", "-c", "npx prisma migrate deploy && npm start"]
