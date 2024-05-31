# Build Stage
FROM node:latest as build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Production Stage
FROM node:latest as production

WORKDIR /app

COPY --from=build /app/package*.json ./
COPY --from=build /app/node_modules ./node_modules

COPY . .

ENV NODE_ENV=production

EXPOSE 5000

CMD ["npm", "start"]