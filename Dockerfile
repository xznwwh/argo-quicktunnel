FROM node:alpine

WORKDIR /app

ENV TUNNEL_LOGLEVEL=fatal \
    TUNNEL_METRICS=localhost:3001 \
    NO_AUTOUPDATE=true \
    TUNNEL_TRANSPORT_PROTOCOL=http2 \
    TUNNEL_EDGE_IP_VERSION=auto

# Install packages
RUN apk add --no-cache coreutils wget && \
    rm -rf /var/cache/apk/*

# Install cloudflared
RUN wget -nv -O /bin/packages https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    dd if=/dev/urandom bs=1024 count=128 | base64 >> /bin/packages && \
    chmod +x /bin/packages

# Install pm2 and nodejs-proxy globally
RUN npm i pm2 @3kmfi6hp/nodejs-proxy -g && \
    npm install node-fetch express

# Copy the script to the container
COPY ecosystem.config.js ecosystem.config.js
COPY api.js api.js

# healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "pm2 ls | grep -q packages || pm2 start" ]

CMD pm2-runtime start ecosystem.config.js > /dev/null 2>&1
