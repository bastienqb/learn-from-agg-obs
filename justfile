# Developer tooling justfile

# Show all available commands
default:
    @just --list

# Lint files with pre-commit hooks
lint:
    pre-commit run --all-files

# Run the test suite with coverage reporting
test:
    pytest --cov=src --cov-report=term-missing --cov-report=html

# Build the Python package using uv
build *args:
    uv build {{args}}

# Clean the developer environment
clean:
    if [ -d .venv ]; then rm -r .venv; fi
    if [ -d uv.lock ]; then rm -r uv.lock; fi

# Set up the development environment
setup: clean
    uv sync --no-install-project --no-cache -U
    uv sync
    uv tool install --with pre-commit-uv pre-commit
    pre-commit install --install-hooks
