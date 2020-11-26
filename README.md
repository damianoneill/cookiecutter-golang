# cookiecutter-golang

Powered by [Cookiecutter](https://github.com/audreyr/cookiecutter)

## Features

- Generates
    - Makefile
    - go.mod/go.sum
    - tools.go
    - cobra/viper based mainline
        - cobra completion command
        - cobra version command
    - goreleaser config
    - gitlab-ci config

See below for the features of the makefile

```console
$ make help

Usage:
  make <target> ignore suffix -default e.g. make install

Targets:
  install-default       install the binary
  build-default         build the binary, ignoring vendored code if it exists
  test-default          run test with coverage
  coverage-default      report on test coverage
  fmt-default           organise import and format the code
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
```

## Assumptions

- Generated project will be configuration managed by git
- Assumes you have docker installed / configured

## Usage

```console
$ brew install cookiecutter
```
Or 

```console
$ pip install cookiecutter
```

Then

```console
$ cookiecutter https://github.com/damianoneill/cookiecutter-golang.git
```