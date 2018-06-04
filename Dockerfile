# build stage
FROM rust:1.26.1-slim-stretch AS build-stage

RUN mkdir -p /app
WORKDIR /app

COPY . /app
RUN cargo build --release

# runtime stage
FROM debian:stretch-slim

COPY --from=build-stage /app/target/release/multi-stage /usr/bin/multi-stage

ENTRYPOINT ["/usr/bin/multi-stage"]
