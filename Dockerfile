FROM golang:1.17-alpine AS build
ARG project
ADD ./ /app/
RUN cd /app && \
    rm -rf target/ && \
    mkdir -p target/ && \
    cp cmd/${project}/${project}-example.toml target/${project}.toml && \
    GO111MODULE=on go build -mod=vendor -o target/${project} cmd/${project}/main.go

FROM alpine:3.15
COPY --from=build /app/target/ /app/
