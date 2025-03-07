# SSHBindpy Python Wrapper

**SSHBindpy** is a Python wrapper for the [SSHBind](https://github.com/Xyhlon/SSHBind) Rust library. It provides a Pythonic interface to bind remote services—located behind multiple SSH jump hosts—to a local socket. The package exports a single context manager: **SSHBinding**.

## Features

- **Single Public API:**
  Only the `SSHBinding` context manager is exposed. All internal functionality (i.e. the underlying `bind` and `unbind` functions) is hidden.
- **Automatic Resource Management:**
  The context manager binds a remote service upon entering the context and unbinds it upon exit.
- **Secure Credential Handling:**
  Uses SOPS-encrypted YAML files for secure and reproducible credential management.
- **Rust-Powered Efficiency:**
  Leverages the performance and reliability of the SSHBind Rust library.

## System Requirements

Before using SSHBindpy, ensure your system meets the following prerequisites:

- **OpenSSL:** Provides necessary cryptographic functions.
- **SOPS:** Required for decrypting encrypted YAML credential files.
- **Python:** Version 3.8 or later.
- **Rust Toolchain (Optional):** Necessary for building the Rust extension (install via [rustup](https://rustup.rs/)).
- **Nix/direnv (Optional):** For reproducible development environments.

## Installation

### From PyPI

```bash
pip install sshbind
```

### From Source Using Maturin

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/Xyhlon/SSHBindpy.git
   cd SSHBindpy
   ```

2. **Build the Package:**

   With maturin:
   ```bash
   maturin build --release
   ```
   Or using Nix:
   ```bash
   nix build
   ```

3. **Install the Built Wheel:**

   Locate the wheel in the `target/wheels/` directory and install it:
   ```bash
   pip install target/wheels/sshbind-*.whl
   ```

## Usage

sshbind exports a single context manager: `SSHBinding`. Use it to bind a remote service to a local socket. The context manager automatically calls the underlying Rust functions to bind on entry and unbind on exit.

```python
from sshbind import SSHBinding

with SSHBinding("127.0.0.1:8000", ["jump1:22", "jump2:22"], "remote.service:80", "secrets.yaml") as binding:
    # Use the bound service within this block.
    # The remote service is bound when entering the context,
    # and unbound automatically when exiting.
    pass
```

## Development

### Using Nix or direnv

For a reproducible development environment, you can use either Nix or direnv.

- **With Nix:**
  ```bash
  nix develop
  ```
  This command opens a shell with all necessary dependencies (Rust toolchain, OpenSSL, SOPS, etc.) preconfigured.

- **With direnv:**
  Create a `.envrc` file containing your environment variables and run:
  ```bash
  direnv allow
  ```

### Without Nix

If you choose not to use Nix, ensure you have the following installed:

- **Rust Toolchain:** Install via [rustup](https://rustup.rs/).
- **OpenSSL:** Install using your system’s package manager.
- **SOPS:** Install from your package manager or [from source](https://github.com/mozilla/sops).
- **Maturin:** Install with pip:
  ```bash
  pip install maturin
  ```

Then build the package as described above.

## Building and Publishing

### Building the Package

- **With Nix:**
  ```bash
  nix build
  ```
- **With Maturin:**
  ```bash
  maturin build --release
  ```

### Publishing the Package

To publish sshbind using maturin:

**Publish Using Maturin:**
   ```bash
   maturin publish
   ```

## Developer Dependencies

- **Maturin:** Build backend for compiling the Python extension.
- **Rust Toolchain:** For compiling the underlying Rust code.
- **Nix/direnv (Optional):** For reproducible development environments.
- **Python 3.8+:** The minimum supported Python version.

## Additional Resources

- **SSHBind Documentation:**
  [https://docs.rs/sshbind/latest/sshbind/index.html](https://docs.rs/sshbind/latest/sshbind/index.html)
- **SSHBind GitHub Repository:**
  [https://github.com/Xyhlon/SSHBind](https://github.com/Xyhlon/SSHBind)

## License

SSHBindpy is licensed under the MIT License. See the LICENSE file for details. The underlying SSHBind library is also licensed under the MIT License.

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a new branch for your changes.
3. Commit and push your changes.
4. Open a pull request for review.
