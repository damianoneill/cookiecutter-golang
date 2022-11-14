# REQUIRED SECTION
include $(PWD)/.env.sh
include $(PWD)/.golang.mk
# END OF REQUIRED SECTION

# Run 'make help' for the list of default targets

# Example of overriding of default target
#test: ## run test with coverage using the vendor directory
#	go test -mod vendor -v -cover ./... -coverprofile cover.out

# Threshold increased from default
# coverage: test
# 	$(GOBIN)/goverreport -coverprofile=cover.out -sort=block -order=desc -threshold=95

image: ## build the docker image with amd64 support
image:
	@echo ">>> build docker image"
	@DOCKER_DEFAULT_PLATFORM=linux/amd64 docker build -t $(GOMODULE):latest .