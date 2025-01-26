#!/usr/bin/env python3
"""Extract version from the `pyproject.toml` file."""

import tomllib

with open("pyproject.toml", "rb") as f:
    pyproject = tomllib.load(f)

print(pyproject["project"]["version"])  # noqa: T201
