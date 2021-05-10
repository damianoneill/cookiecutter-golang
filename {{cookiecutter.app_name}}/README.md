# {{cookiecutter.app_name}}
## Build

The following make targets are available with this project.

```bash
$ make help


Usage:
  make <target> ignore suffix -default e.g. make install

Targets:
  all-default           run the tools mod, generate, fmt, test, lint and install targets
  release-default       generate release
  install-default       install the binary
  build-default         build the binary, ignoring vendored code if it exists
  test-default          run test with coverage
  coverage-default      report on test coverage
  fmt-default           format the code
  mod-default           makes sure go.mod matches the source code in the module
  archive-default       archive the third party dependencies, typically prior to generating a tagged release
  lint-default          run golangci-lint using the configuration in .golangci.yml
  generate-default      go generate code
  tools-default         install the project specific tools into $GOBIN
  runner-default        execute the gitlab runner using the configuration in .gitlab-ci.yml
  snapshot-default      generate a snapshot release using goreleaser
  licenses-default      print list of licenses for third party software used in binary
  add-license-default   add copyright license headers to go source code
  security-default      run go security check
  outdated-default      check for outdated direct dependencies
  lines-default         shorten lines longer than 100 chars, ignore generated
  authors-default       update the AUTHORS file
  changelog-default     update the CHANGELOG.md
```
