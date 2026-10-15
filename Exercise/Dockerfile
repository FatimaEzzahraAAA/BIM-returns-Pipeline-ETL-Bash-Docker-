FROM alpine:3.20
RUN apk add --no-cache bash gawk coreutils
WORKDIR /app
COPY returns_processor.sh /app
RUN chmod +x returns_processor.sh
CMD ["bash", "/app/returns_processor.sh"]
