FROM rust:alpine AS builder

RUN apk add --no-cache gcc musl-dev
WORKDIR /src

COPY Cargo.toml Cargo.lock ./
COPY src ./src

RUN RUSTFLAGS="-C strip=symbols" cargo build --release --locked

FROM scratch

COPY --from=builder /src/target/release/hello_world /hello_world
ENTRYPOINT ["/hello_world"]
