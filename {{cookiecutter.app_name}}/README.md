# {{cookiecutter.app_name}}

## Prerequisites

This project uses the following tools:

- Make
- [pre-commit.com](https://pre-commit.com/)
- Go {{cookiecutter.golang_version}}
- Docker

Ensure before starting that you have installed the above and that you then run
the following commands in the project directory. Its assumed that the project
has been:

```console
git init . && git add . && git commit -m 'initial project skeleton' .
```

Run

```console
make tools
```

And finally

```console
pre-commit install && pre-commit run --all-files
```

## Build

The following make targets are available with this project.

<!-- START makefile-doc -->
```bash
$ make help


Usage:
  make <target> ignore suffix -default e.g. make install

Targets:
  install-default       install the binary
  build-default         build the binary, ignoring vendored code if it exists
  test-default          run test with coverage
  coverage-default      report on test coverage
  fmt-default           format the code
  mod-default           makes sure go.mod matches the source code in the module
  archive-default       archive the third party dependencies, typically prior to generating a tagged release
  lint-default          run golangci-lint using the configuration in .golangci.yml
  generate-default      go generate code
  tools-default         install the project specific tools
  runner-default        execute the gitlab runner using the configuration in .gitlab-ci.yml
  snapshot-default      generate a snapshot release using goreleaser
  licenses-default      print list of licenses for third party software used in binary, if using repeatedly, use GITHUB_TOKEN
  security-default      run go security check
  outdated-default      check for outdated direct dependencies
  lines-default         shorten lines longer than 100 chars, ignore generated
  authors-default       update the AUTHORS file
  changelog-default     update the CHANGELOG.md
```
<!-- END makefile-doc -->
