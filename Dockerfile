#FROM alpine:latest
FROM rclone/rclone:latest
WORKDIR /

RUN apk update && \
    apk upgrade

# Install supervisor services
RUN apk add --no-cache supervisor

# Install AVAHI mDNS/DNS-SD protocol suite
RUN apk add --no-cache avahi
EXPOSE 5353/udp

# Install SAMBA
RUN apk add --no-cache samba-common-tools samba-client samba
EXPOSE 137/udp 138/udp 139 445


COPY config/ /config

# Install RCLONE
# RUN apk add --no-cache curl unzip
# RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
#     unzip rclone-current-linux-amd64.zip && \
#     cd rclone-*-linux-amd64 && \
#     cp rclone /usr/bin/ && \
#     chmod 755 /usr/bin/rclone && \
#     chmod +x /usr/bin/rclone && \
#     rm -rf rclone-current-linux-amd64.zip rclone-*-linux-amd64

# Clean cache
RUN rm -rf /var/cache/apk/*


ENTRYPOINT ["supervisord", "-c", "/config/supervisord.conf"]

CMD []
