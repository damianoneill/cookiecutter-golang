module {{cookiecutter.app_server_host}}/{{cookiecutter.app_namespace}}/{{cookiecutter.app_name}}/tools

go {{ cookiecutter.golang_version.split('.')[0] }}.{{ cookiecutter.golang_version.split('.')[1] }}

require (
    github.com/goreleaser/goreleaser v1.1.0 // later versions require 1.18
    github.com/segmentio/golines v0.6.0 // later versions require 1.18
)