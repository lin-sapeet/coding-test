FROM node:20-bullseye-slim

RUN apt-get update && apt-get install -y \
    sqlite3 \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace/app
RUN mkdir -p /workspace/app/node_modules
COPY ./app/package*.json ./app/yarn*.lock ./
RUN yarn install

RUN chown -R node:node ./
USER node

# Next.jsによってテレメトリデータを収集するのを無効にする
ARG NEXT_TELEMETRY_DISABLED=1
ENV NEXT_TELEMETRY_DISABLED=$NEXT_TELEMETRY_DISABLED

CMD ["yarn", "dev"]
