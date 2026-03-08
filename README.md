# 🔐 VAULTA

> **Lightning-fast, secure password management that just works.**

[![Rust](https://img.shields.io/badge/Rust-000000?style=for-the-badge&logo=rust&logoColor=white)](https://rust-lang.org)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Build Status](https://img.shields.io/badge/Build-Passing-brightgreen?style=for-the-badge)](https://github.com/0xshariq/vaulta)

---

## ⚡ Why Vaulta?

**vaulta is the password manager that gets out of your way.** Built in Rust for blazing performance and iron-clad security, it's designed for developers who value speed, simplicity, and reliability.

### 🚀 **Setup in 30 seconds**
```bash
# Install and initialize in one go
cargo install vaulta
vaulta init my-vault
vaulta add github
# Done! Your first password is stored and encrypted.
```

### 🔒 **Enterprise-grade security**
- **Argon2** key derivation with vault-specific salts
- **ChaCha20-Poly1305** authenticated encryption
- **Zero-knowledge** architecture - your data never leaves your device
- **Git integration** for version control and backup

### ⚡ **Lightning fast**
- **Rust-powered** performance
- **No cloud dependencies** - everything runs locally
- **Instant search** across all your data
- **Smart caching** - unlock once, use all day

---

## 🚀 Quick Start

### Prerequisites
- Rust 1.70+ ([install here](https://rustup.rs/))
- Git (for version control)

### Local Development
```bash
# Clone and build
git clone https://github.com/0xshariq/vaulta.git
cd vaulta
cargo build --release

# Initialize your first vault
./target/release/vaulta init my-vault

# Add your first password
./target/release/vaulta add github

# List all passwords
./target/release/vaulta list

# Copy password to clipboard
./target/release/vaulta copy github
```

### Docker (Recommended for Production)
```bash
# Build and run with Docker Compose
docker-compose up --build

# Or build manually
docker build -t vaulta .
docker run -it --rm -v $(pwd)/vaults:/app/vaults vaulta init my-vault
```

---

## 🎯 Core Features

| Feature | Description | Speed |
|---------|-------------|-------|
| **🔐 Password Storage** | Encrypted passwords with metadata | Instant |
| **🔍 Smart Search** | Search across all fields (hidden from UI) | <100ms |
| **📋 Clipboard Integration** | Auto-clear with configurable timeout | <50ms |
| **🏷️ Rich Metadata** | Usernames, notes, URLs, tags, custom fields | Instant |
| **🔄 Git Sync** | Version control and backup | <1s |
| **📤 Import/Export** | Vault portability across devices | <2s |
| **🔒 Session Management** | Unlock once, use all day | <100ms |

---

## 🛠️ Commands

### Essential Commands
```bash
vaulta init <vault>          # Create new vault
vaulta add <key>             # Add password
vaulta get <key>             # View password
vaulta copy <key>            # Copy to clipboard
vaulta list                  # List all entries
vaulta search <query>        # Search entries
vaulta edit <key>            # Edit entry
vaulta delete <key>          # Remove entry
```

### Advanced Commands
```bash
vaulta vault use <name>      # Switch vaults
vaulta vault export          # Export vault
vaulta vault import <file>   # Import vault
vaulta git status            # Git status
vaulta git commit            # Commit changes
vaulta git push              # Push to remote
vaulta backup                # Create backup
vaulta restore <backup>      # Restore from backup
```

---

## 🐳 Docker Support

### Dockerfile
```dockerfile
FROM rust:1.75-alpine as builder
WORKDIR /app
COPY . .
RUN cargo build --release

FROM alpine:latest
RUN apk add --no-cache git
COPY --from=builder /app/target/release/vaulta /usr/local/bin/
WORKDIR /app
VOLUME ["/app/vaults"]
ENTRYPOINT ["vaulta"]
```

### Docker Compose
```yaml
version: '3.8'
services:
  vaulta:
    build: .
    volumes:
      - ./vaults:/app/vaults
      - ~/.ssh:/root/.ssh:ro  # For Git operations
    environment:
      - RUST_LOG=info
    working_dir: /app
    command: ["init", "my-vault"]
```

### .dockerignore
```
target/
.git/
.gitignore
README.md
Dockerfile
docker-compose.yml
```

---

## 🔧 Configuration

### Vault Structure
```
~/.vaulta/
├── config.toml          # Global configuration
├── vaults/
│   ├── my-vault/
│   │   ├── config.toml  # Vault-specific config
│   │   ├── entries/     # Encrypted password files
│   │   ├── .git/        # Git repository
│   │   └── sessions/    # Session data
│   └── work-vault/
└── sessions/            # Global sessions
```

### Environment Variables
```bash
vaulta_VAULT_NAME=my-vault    # Default vault
vaulta_SESSION_TIMEOUT=86400  # Session timeout (seconds)
vaulta_CLIPBOARD_TIMEOUT=45   # Clipboard clear timeout
```

---

## 🔒 Security Features

- **Zero-knowledge encryption** - Your master password never leaves your device
- **Vault-specific salts** - Each vault has unique cryptographic parameters
- **Authenticated encryption** - ChaCha20-Poly1305 prevents tampering
- **Secure memory handling** - Zeroize sensitive data after use
- **Git integration** - Version control and audit trail
- **Session isolation** - Vaults are completely isolated

---

## 🤝 Contributing

We love contributions! Here's how to get started:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Development Setup
```bash
git clone https://github.com/0xshariq/vaulta.git
cd vaulta
cargo build
cargo test
cargo fmt
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Ready to secure your digital life?** 🚀

```bash
cargo install vaulta
vaulta init my-vault
```

*Questions? [Open an issue](https://github.com/0xshariq/vaulta/issues) or [join our discussions](https://github.com/0xshariq/vaulta/discussions)!*
