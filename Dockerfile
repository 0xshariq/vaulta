# Multi-stage build for vaulta password manager
FROM rust:1.75-alpine as builder

# Install build dependencies
RUN apk add --no-cache \
    musl-dev \
    openssl-dev \
    pkgconfig \
    git

WORKDIR /app

# Copy dependency files first for better caching
COPY Cargo.toml Cargo.lock ./

# Create a dummy main.rs to build dependencies
RUN mkdir src && \
    echo "fn main() {}" > src/main.rs && \
    cargo build --release && \
    rm -rf src

# Copy source code
COPY . .

# Build the application
RUN cargo build --release --bin vaulta

# Runtime stage
FROM alpine:latest

# Install runtime dependencies
RUN apk add --no-cache \
    git \
    ca-certificates \
    tzdata

# Create non-root user
RUN addgroup -g 1000 vaulta && \
    adduser -D -s /bin/sh -u 1000 -G vaulta vaulta

# Create app directory
WORKDIR /app

# Copy binary from builder stage
COPY --from=builder /app/target/release/vaulta /usr/local/bin/vaulta

# Create vaults directory
RUN mkdir -p /app/vaults && \
    chown -R vaulta:vaulta /app

# Switch to non-root user
USER vaulta

# Set volume for vaults
VOLUME ["/app/vaults"]

# Set environment variables
ENV RUST_LOG=info
ENV vaulta_VAULT_PATH=/app/vaults

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD vaulta --help || exit 1

# Default command
ENTRYPOINT ["vaulta"]

# Default to help if no command provided
CMD ["--help"]
