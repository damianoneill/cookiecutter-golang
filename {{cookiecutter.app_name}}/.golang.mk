MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR := $(notdir $(patsubst %/,%,$(dir $(MAKEFILE_PATH))))

# Go related variables
GOPATH := $(CURDIR)/.go
GOBIN := $(GOPATH)/bin
GO := GOPATH=$(GOPATH) go
GOFMT := GOPATH=$(GOPATH) gofmt
GOIMPORTS := GOPATH=$(GOPATH) goimports
GOMODULE := $(shell $(GO) list)
GOSRC := $(shell find . -type f -name "*.go" -not -path "./vendor/*" -not -path "./.go/*" -not -path "*/mocks/*") # used when tools are not vendor aware

LD_VERSION = x.x.x
LD_COMMIT = 001
ifeq ($(shell git rev-parse --is-inside-work-tree 2>/dev/null),true)
LD_VERSION = $(shell git describe --tags --abbrev=0 --dirty=-next 2>/dev/null)
LD_COMMIT = $(shell git rev-parse HEAD)
endif 
LD_DATE := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
LD_FLAGS := -s -w -X $(GOMODULE)/cmd.version=$(LD_VERSION) -X $(GOMODULE)/cmd.commit=$(LD_COMMIT) -X $(GOMODULE)/cmd.date=$(LD_DATE)


# third party versions
GOLANGCI_LINT_VERSION := v1.32.2

all: mod generate fmt test lint install

.PHONY: install-default
install-default: ## install the binary
	@echo ">>> go install "
	@$(GO) install -ldflags="$(LD_FLAGS)" ./...

.PHONY: build-default
build-default: ## build the binary, ignoring vendored code if it exists
	@echo ">>> go build "
	@$(GO) build -ldflags="$(LD_FLAGS)" ./...
        
.PHONY: test-default
test-default: ## run test with coverage
	@echo ">>> go test "
	@$(GO) test -v -cover ./... -coverprofile cover.out

.PHONY: coverage-default
coverage-default: ## report on test coverage
coverage-default: test 
	@echo ">>> govereport "
	@$(GOBIN)/goverreport -coverprofile=cover.out -sort=block -order=desc -threshold=85

.PHONY: fmt-default
fmt-default: ## organise import and format the code
	@echo ">>> goimports && gofmt" # dont show real command as src could be huge
	@$(GOIMPORTS) -w $(GOSRC)
	@$(GOFMT) -s -w $(GOSRC)

.PHONY: mod-default
mod-default: ## makes sure go.mod matches the source code in the module
	@echo ">>> go mod tidy "
	@$(GO) mod tidy

.PHONY: archive-default
archive-default: ## archive the third party dependencies, typically prior to generating a tagged release
	@echo ">>> go mod vendor"
	@$(GO) mod vendor

.PHONY: lint-default
lint-default: ## run golangci-lint using the configuration in .golangci.yml
	@echo ">>> golangci-lint run "
	@$(GOBIN)/golangci-lint run

.PHONY: generate-default
generate-default: ## go generate code
	@echo ">>> go generate "
	@$(GO) generate ./...
	
.PHONY: tools-default
tools-default: ## install the project specific tools
tools-default:
	cat tools.go | grep _ | awk -F'"' '{print $$2}' | xargs -tI % $(GO) install %
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(GOPATH)/bin $(GOLANGCI_LINT_VERSION)

	
.PHONY: runner-default
runner-default: ## execute the gitlab runner using the configuration in .gitlab-ci.yml
	gitlab-runner exec docker --cache-dir /cache --docker-volumes 'cache:/cache' test

.PHONY: snapshot-default
snapshot-default: ## generate a snapshot release using goreleaser
	@echo ">>> goreleaser "
	@$(GOBIN)/goreleaser --snapshot --rm-dist

.PHONY: licenses-default
licenses-default: ## print list of licenses for third party software used in binary, if using repeatedly, use GITHUB_TOKEN
licenses-default: install
	@echo ">>> golicense "
	@$(GOBIN)/golicense .approved-licenses.json $(GOPATH)/bin/$(CURRENT_DIR)

.PHONY: security-default
security-default: ## run go security check
security-default:
	@echo ">>> gosec "
	@$(GOBIN)/gosec -conf .gosec.json ./...

.PHONY: outdated-default
outdated-default: ## check for outdated direct dependencies
outdated-default:
	@echo ">>> go-mod-outdated "
	@$(GO) list -u -m -json all | go-mod-outdated -direct

.PHONY: lines-default
lines-default: ## shorten lines longer than 100 chars, ignore generated
lines-default:
	@echo ">>> golines "
	@$(GOBIN)/golines --ignore-generated -m 100 -w .

.PHONY: help-default
help-default:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m ignore suffix -default e.g. make install \n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

%:  %-default
	@  true