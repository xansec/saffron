# Build Stage
FROM --platform=linux/amd64 rustlang/rust:nightly as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang

## Add source code to the build stage.
ADD . /saffron
WORKDIR /saffron/saffron

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN cargo build --examples

# Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /saffron/saffron/target/debug/examples/describe /
