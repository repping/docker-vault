# Base
FROM alpine:latest

# Provisioning
RUN mkdir -p /etc/vault.d
RUN mkdir -p /opt/vault/data
RUN addgroup vault
RUN adduser -S -G vault vault
RUN apk add --no-cache ca-certificates libcap su-exec dumb-init tzdata
# RUN apk update && apk add --no-cache ca-certificates gnupg openssl libcap su-exec dumb-init tzdata wget unzip procps util-linux
RUN apk add --no-cache vault~=1.10.5
RUN setcap cap_ipc_lock=-ep /usr/sbin/vault


# Copy files
COPY vault.hcl /etc/vault.d/vault.hcl

# Environment variables
# ENV VAULT_ADDR="http://127.0.0.1:8200"

# Exposure
EXPOSE 8200

# Entrypoint script
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# Start application
CMD ["server", "-dev", "-dev-root-token-id=roottoken"]