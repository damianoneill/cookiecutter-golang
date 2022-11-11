# Start by building the application.
FROM golang:{{cookiecutter.golang_version}} as build

WORKDIR /go/src/app
# insructions below, will create a layer that caches the dependencies of the application.
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN go mod download

RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/{{cookiecutter.app_name}}

# Now copy it into our base image.
FROM gcr.io/distroless/base-debian11

COPY --from=build --chown=nonroot:nonroot /go/bin/{{cookiecutter.app_name}} /

USER nonroot
CMD ["/{{cookiecutter.app_name}}"]
