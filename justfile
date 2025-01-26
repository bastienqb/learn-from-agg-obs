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

# Set up the development environment
setup:
    [ -d .venv ] || uv venv .venv
    uv tool install --with pre-commit-uv pre-commit
    uv pip install -e ".[dev]"
    pre-commit install --install-hooks
