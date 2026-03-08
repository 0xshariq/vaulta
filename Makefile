.PHONY: help build run dev clean test docker-build docker-run docker-dev docker-clean

# Default target
help:
	@echo "🔐 vaulta Password Manager - Available Commands:"
	@echo ""
	@echo "📦 Build & Run:"
	@echo "  build        Build the release binary"
	@echo "  run          Run the binary"
	@echo "  dev          Run in development mode"
	@echo "  clean        Clean build artifacts"
	@echo "  test         Run tests"
	@echo ""
	@echo "🐳 Docker:"
	@echo "  docker-build Build Docker image"
	@echo "  docker-run   Run Docker container"
	@echo "  docker-dev   Run development container"
	@echo "  docker-clean Clean Docker artifacts"
	@echo ""
	@echo "🚀 Quick Start:"
	@echo "  make build && make run"

# Build the release binary
build:
	@echo "🔨 Building vaulta..."
	cargo build --release
	@echo "✅ Build complete! Binary: ./target/release/vaulta"

# Run the binary
run: build
	@echo "🚀 Running vaulta..."
	./target/release/vaulta

# Development mode
dev:
	@echo "🔧 Running in development mode..."
	cargo run

# Clean build artifacts
clean:
	@echo "🧹 Cleaning build artifacts..."
	cargo clean
	@echo "✅ Clean complete!"

# Run tests
test:
	@echo "🧪 Running tests..."
	cargo test
	@echo "✅ Tests complete!"

# Docker build
docker-build:
	@echo "🐳 Building Docker image..."
	docker build -t vaulta:latest .
	@echo "✅ Docker build complete!"

# Docker run
docker-run: docker-build
	@echo "🐳 Running Docker container..."
	docker run -it --rm \
		-v $(PWD)/vaults:/app/vaults \
		-v ~/.ssh:/home/vaulta/.ssh:ro \
		--network host \
		vaulta:latest

# Docker development
docker-dev:
	@echo "🐳 Running development container..."
	docker-compose --profile dev up --build

# Docker clean
docker-clean:
	@echo "🧹 Cleaning Docker artifacts..."
	docker system prune -f
	docker image rm vaulta:latest 2>/dev/null || true
	@echo "✅ Docker clean complete!"

# Install dependencies
install:
	@echo "📦 Installing dependencies..."
	cargo install cargo-watch
	@echo "✅ Dependencies installed!"

# Format code
fmt:
	@echo "🎨 Formatting code..."
	cargo fmt
	@echo "✅ Code formatted!"

# Lint code
lint:
	@echo "🔍 Linting code..."
	cargo clippy
	@echo "✅ Linting complete!"

# Full development setup
setup: install fmt lint
	@echo "🚀 Development environment ready!"

# Quick vault operations
init-vault:
	@echo "🔐 Initializing vault..."
	./target/release/vaulta init my-vault

add-password:
	@echo "🔑 Adding password..."
	./target/release/vaulta add github

list-passwords:
	@echo "📋 Listing passwords..."
	./target/release/vaulta list

# Show help by default
.DEFAULT_GOAL := help
