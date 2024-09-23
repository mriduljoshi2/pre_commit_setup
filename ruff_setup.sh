#!/bin/bash

set -e

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo "Error: This script should be run from the root of a Git repository."
    exit 1
fi

# Create pre-commit file in .git/hooks
cat > .git/hooks/pre-commit << EOL
# Run pre-commit
if command -v pre-commit >/dev/null 2>&1; then
  exec pre-commit run --hook-stage commit
else
  echo "pre-commit not found. Please install it: pip install pre-commit"
  exit 1
fi
EOL

echo "Created .git/hooks/pre-commit file"

# Create .pre-commit-config.yaml
cat > .pre-commit-config.yaml << EOL
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.6.6
    hooks:
      # Run diff linter (shows diff of changes to be auto-fixed)
      - id: ruff
        name: ruff (show diff)
        stages: [commit]
        # --exit-non-zero-on-fix
        args: [--fix, --diff]
      # Run fix linter (runs auto-fix, displays fixes made and other errors to be fixed)
      - id: ruff
        name: ruff (auto-fix + errors)
        args: [--fix, --show-fixes]
        stages: [commit]
      # Run the formatter
      - id: ruff-format
        stages: [commit]
EOL

echo "Created .pre-commit-config.yaml"

# Ruff configuration
RUFF_CONFIG="
[tool.ruff]
# Exclude a variety of commonly ignored directories.
exclude = [
    \".bzr\",
    \".direnv\",
    \".eggs\",
    \".git\",
    \".git-rewrite\",
    \".hg\",
    \".ipynb_checkpoints\",
    \".mypy_cache\",
    \".nox\",
    \".pants.d\",
    \".pyenv\",
    \".pytest_cache\",
    \".pytype\",
    \".ruff_cache\",
    \".svn\",
    \".tox\",
    \".venv\",
    \".vscode\",
    \"__pypackages__\",
    \"_build\",
    \"buck-out\",
    \"build\",
    \"dist\",
    \"node_modules\",
    \"site-packages\",
    \"venv\",
]

[tool.ruff.lint]
# I - isort formatting
# D - checking docstrings
# F401 - remove unused imports
select = [\"I\", \"D\", \"F401\"]
extend-select = []
fixable = [\"ALL\"]
unfixable = []

# D415 - checking ending punctuation
# N - pep8-naming
# PLR0915 - too many statements
# C901 - cyclomatic complexity
# ANN - type annotations
# TCH - type checking
ignore = [\"D415\", \"N\", \"PLR0915\", \"C901\", \"ANN\", \"TCH\"]

#[tool.ruff.lint.mccabe]
# Flag errors (C901) whenever the complexity level exceeds 5.
#max-complexity = 5

#[tool.ruff.lint.pylint]
# setting maximum function length to 30 statements
#max-statements = 30

# setting docstring convention to google format
[tool.ruff.lint.pydocstyle]
convention = \"google\"
"

# Add Ruff configuration to existing pyproject.toml or create a new one
if [ -f pyproject.toml ]; then
    echo "pyproject.toml already exists. Adding Ruff configuration to it."
    echo "$RUFF_CONFIG" >> pyproject.toml
else
    echo "Creating pyproject.toml with Ruff configuration."
    cat > pyproject.toml << EOL
$RUFF_CONFIG
EOL
fi

# Install pre-commit
echo "Installing pre-commit..."
pip install pre-commit

# Install pre-commit hooks
echo "Installing pre-commit hooks..."
pre-commit install

echo -e "\nRuff and pre-commit have been set up successfully!"
