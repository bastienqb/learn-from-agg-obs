# Developing guidelines

First off, thank you for considering contributing to *learning-from-agg-obs*!
It is people like *you* who make it such a great tool for everyone.

This document intends to make contribution easier by codifying tribal knowledge and expectations.
Don't be afraid to open half-finished PRs, and ask questions if something is unclear!

1. [Setting up your environment](#development-setup)
2. [Developing a new feature](#development-workflow)
3. [Styling your code](#code-style)
4. [Testing your code](#tests)
5. [Documenting your code](#documentation)
6. [Releasing a new version](#release)

## Development setup

### Pre-requisites

To get started, you'll need a few handy development tools - these are common tools that you might already be using:
- [uv](https://docs.astral.sh/uv/getting-started/installation/), an extremely fast Python package and project manager.
- [just](https://just.systems/man/en/introduction.html), a cross-platform equivalent of Makefile to run tasks.

### Installation

Let's get you up and running with the project. Here's how to set it up:

1. First, fork the repository into your own Github account.
   Here is a [step-by-step guide](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo#about-forks) to help you.
   Make sure to only fork the `main` branch and not all the feature branches.

2. Clone the __forked__ repository to your computer by running:
   ```bash
   git clone https://github.com/<YOUR-USERNAME>/learn-from-agg-obs
   ```

3. Setup your local repository to be able to regularly sync it with the original repository
   ```bash
   git remote add upstream https://github.com/bastienqb/learn-from-agg-obs
   ```
   You can refer to this [detailed guide](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo#configuring-git-to-sync-your-fork-with-the-upstream-repository).

4. Once that's done, head to the main project folder and run our setup command:
   ```bash
   just setup
   ```

   This setup command takes care of all the project configuration for you - it handles your linting rules, testing framework, documentation tools, and packaging settings.

You are ready to start developing right away :tada:.

## Development workflow

Any new fix or feature you want to develop should be done in a distinct branch branched off from the `main` branch and not the `main` branch itself.

But before starting any development, you need to sync your local `main` branch with the `main` branch from the original project.

### Sync your fork

You only need a few steps to sync your fork with the original repository:

1. Get all the latest changes from `upstream` (i.e. the original repository):
   ```bash
   git fetch upstream
   ```

2. Make sure you are on the `main` branch of your repository:
   ```bash
   git checkout main
   ```

3. Update your fork's `main` branch with `upstream` changes:
   ```bash
   git merge upstream/main
   ```
   Hopefully you have not committed anything on your `main` branch so the merge should be a "fast-forward".

4. Do not forget to push the updates to your fork on GitHub to keep it updated as well:
   ```bash
   git push origin main
   ```

### Create a new branch

Now that your `main` branch is synced with the original project, you can create your new branch from the `main` branch:

```bash
git checkout -b your-new-branch-name
```

We use 2 types of branches:

- __fix__ branches, which are used to fix bug.
  They are named `fix/issue-{issue number}-{2-3 word summary split with '-'}`
- __feature__ branches, which are used to develop new features.
  They are named `feature/issue-{issue number}-{2-3 word summary split with '-'}`

### Commit your changes

It is good practise to regularly commit your changes when you develop new code.
The fundamental principal is that each commit should represent a logical chunk of work.

The commit message should follow the [Conventional Commit](https://www.conventionalcommits.org/en/v1.0.0/) convention.
To make your work easier, we suggest two options:

- use [Commitizen](https://commitizen-tools.github.io/commitizen/) in your terminal [already installed for you]:

  ```bash
  cz commit
  ```

  It will ask you some questions about your commit to format properly.

- use the [VS Code Conventional Commit extension](https://marketplace.visualstudio.com/items?itemName=vivaxy.vscode-conventional-commits)

Be aware that this project runs [pre-commit checks](https://pre-commit.com/) to enforce quality standards.
It means that you will not be able to commit your code if those checks do not pass.

We recommend to run the checks manually and resolve the issue before you commit your code, with:

```bash
just lint
```

### Update your branch

You should regularly update your feature branch with the latest changes ported in the `main` branch of the original repository:

1. Sync your `main` branch (already described [above](#sync-your-fork))

2. Rebase your feature branch:

   ```bash
   git checkout <your branch>
   git rebase main
   ```

3. If there are conflicts, Git will pause and let you resolve them.
   After that, you can resume the rebase process:

   ```bash
   git rebase --continue
   ```

4. Update your remote feature branch to share your changes with others:

  ```bash
  git push --force-with-lease origin <your branch>
  ```

### Open a pull request

Once your code is ready to be shared with others, you can open a pull request in the original project to merge your feature branch.
The process is described [here](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork).

Do not be shy to open a PR early in the development process.
It is the opportunity to discuss proposed changed with the other developers.

The PR creation triggers the ci pipeline, which runs several checks (e.g. formatting, unit tests, build).
The PR will only be merged when all those checks pass.
Hence, you might need to re-work on your branch and push new commits to pass all the checks.
Do not worry, it is totally normal! The step [Commit your changes](#commit-your-changes) is here to help you.

### Squash your commits

Your PR now passes all the checks, and the maintainers are happy with your work.
The last step is to squash all your commits into a single one, to make the commit history easier to read:

1. Get the hash of the first commit in your branch (we assume you have already rebased your branch against `main`):

   ```bash
   git log main..<your branch> --oneline | tail -1
   ```

2. Reset all your commits:

   ```bash
   git reset --soft <your commit hash>~1
   ```

   It resets all your commit and put your files back in the staging area.

3. Create a single new commit for your branch, following the same convention as in the [Commit your change section](#commit-your-changes)

4. Update your remote branch:

   ```bash
   git push --force-with-lease origin <your branch>
   ```

### Merge the PR

When all the checks pass and the maintainers have approved the PR, it is automatically merged to the `main` branch of the source repository.

Well done to you, you have contributed to this project!

## Code-style

The code style of the repository is enforced with [pre-commit](https://pre-commit.com/).
The tools and rules are defined in both `.pre-commit-config.yaml` and `pyproject.toml`.
It runs automatically every time you create a new commit, and will reject it if it does not respect the code style.

You can also format your code whenever you want using:

```bash
just lint
```

### Source code

This repository uses [Ruff](https://docs.astral.sh/ruff/) to format the code.

### Docstrings

This package uses the [google docstring format](https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html#example-google) for docstrings.

If you use VS Code, the [autoDocstrings extension](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring) generates automatically docstrings with the proper format.

## Tests

Tests are defined in the `tests` directory, and leverage [pytest](https://docs.pytest.org/en/stable/) as the testing framework.

### Test formatting

This repository follows the [Arrange/Act/Assert convention](https://microsoft.github.io/code-with-engineering-playbook/automated-testing/unit-testing/#best-practices) to write tests.

The test functions follow this naming convention: `test_<function-to-be-tested>_<what-is-tested>_<expected-result>`.

It is sometimes necessary to add a detailed description in the docstrings, as explained [here](https://jml.io/pages/test-docstrings.html).

Remember that __writing proper tests__ will help you to __debug faster__ in the future and __is part of the documentation__.

### Local testing

You can use the full test suite with the command:

```
just test
```

It outputs a detailed coverage report.

In case you only want to run a few tests, we see 2 options:

- use pytest in the command line
- use [VS Code to run the tests](https://code.visualstudio.com/docs/python/testing)

### Testing in the CI pipeline

Every time you open or update a PR, the CI pipeline runs the full test suite across multiple python versions and operating systems.

The results of the tests are displayed within the PR using [Codecov](https://docs.codecov.com/docs/quick-start).

## Documentation

TODO

## Release

> This section is only relevant for the maintainers of the project.

TODO
