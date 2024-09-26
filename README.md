# pre_commit_setup

This repository includes a setup script for configuring pre-commit hooks using Ruff, a fast Python linter and code formatter.

## Getting Started

Follow these steps to set up the pre-commit hooks:

1. Ensure you have the `ruff_setup.sh` file in the root of your Git repository.
2. Open a terminal and navigate to the root directory of your repository.
3. Run the setup script:

   ```bash
   ./ruff_setup.sh
   ```

4. The pre-commit hooks are now installed and will run automatically whenever you commit changes.

## What This Does

The `ruff_setup.sh` script sets up pre-commit hooks that will:

- Run Ruff to check your Python code for style and potential errors
- Automatically format your code according to the configured style guidelines

This helps maintain code quality and consistency across your project.

## Requirements

- Git
- Bash-compatible shell
- Python (version requirements may vary based on your project)
- pip

## Troubleshooting

If you encounter any issues with the setup or the pre-commit hooks, please check the following:

- Ensure the `ruff_setup.sh` file has execute permissions:
   ```bash
   chmod +x ruff_setup.sh
   ```
- Verify that you're running the script from the root of your Git repository
- Check that you have the necessary dependencies installed

For more information on Ruff and pre-commit hooks, refer to their respective documentation:

- [Ruff Documentation](https://beta.ruff.rs/docs/)
- [pre-commit Documentation](https://pre-commit.com/)
