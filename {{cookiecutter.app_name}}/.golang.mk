MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR := $(notdir $(patsubst %/,%,$(dir $(MAKEFILE_PATH))))
SRC := $(shell find . -type f -name "*.go" -not -path "./vendor/*") # used when tools are not vendor aware
MODULE := $(shell go list)
LD_VERSION := $(shell git describe --tags --abbrev=0 --dirty=-next)
LD_COMMIT := $(shell git rev-parse HEAD)
LD_DATE := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
LD_FLAGS := -s -w -X $(MODULE)/cmd.version=$(LD_VERSION) -X $(MODULE)/cmd.commit=$(LD_COMMIT) -X $(MODULE)/cmd.date=$(LD_DATE)
GOPATH := $(shell go env GOPATH)

all: mod generate fmt test lint install

.PHONY: install-default
install-default: ## install the binary
	go install -ldflags="$(LD_FLAGS)" ./...

.PHONY: build-default
build-default: ## build the binary, ignoring vendored code if it exists
	go build -ldflags="$(LD_FLAGS)" ./...
        
.PHONY: test-default
test-default: ## run test with coverage
	go test -v -cover ./... -coverprofile cover.out

.PHONY: coverage-default
coverage-default: ## report on test coverage
coverage-default: test 
	goverreport -coverprofile=cover.out -sort=block -order=desc -threshold=85

.PHONY: fmt-default
fmt-default: ## organise import and format the code
	@echo "goimports && gofmt" # dont show real command as SRC could be huge
	@find $(SRC)  -type f  -name "*.go" -not -path "*/mocks/*"  -exec goimports  -w  {} \; && gofmt -s -w $(SRC)

.PHONY: mod-default
mod-default: ## makes sure go.mod matches the source code in the module
	go mod tidy

.PHONY: archive-default
archive-default: ## archive the third party dependencies, typically prior to generating a tagged release
	go mod vendor

.PHONY: lint-default
lint-default: ## run golangci-lint using the configuration in .golangci.yml
	golangci-lint run

.PHONY: generate-default
generate-default: ## go generate code
	go generate ./...
	
.PHONY: tools-default
tools-default: ## install the project specific tools
	cat tools.go | grep _ | awk -F'"' '{print $$2}' | xargs -tI % go install %

.PHONY: runner-default
runner-default: ## execute the gitlab runner using the configuration in .gitlab-ci.yml
	gitlab-runner exec docker --cache-dir /cache --docker-volumes 'cache:/cache' test

.PHONY: snapshot-default
snapshot-default: ## generate a snapshot release using goreleaser
	goreleaser --snapshot --rm-dist

.PHONY: licenses-default
licenses-default: ## print list of licenses for third party software used in binary, if using repeatedly, use GITHUB_TOKEN
licenses-default: install
	golicense .approved-licenses.json $(GOPATH)/bin/$(CURRENT_DIR)

.PHONY: security-default
security-default: ## run go security check
security-default:
	gosec -conf .gosec.json ./...

.PHONY: outdated-default
outdated-default: ## check for outdated direct dependencies
outdated-default:
	go list -u -m -json all | go-mod-outdated -direct

.PHONY: lines-default
lines-default: ## shorten lines longer than 100 chars, ignore generated
lines-default:
	golines --ignore-generated -m 100 -w .

.PHONY: help-default
help-default:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m ignore suffix -default e.g. make install \n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

%:  %-default
	@  true