module {{cookiecutter.app_server_host}}/{{cookiecutter.app_namespace}}/{{cookiecutter.app_name}}/tools

go {{cookiecutter.golang_version}}

require (
    // required because of clash between use in viper and goreleaser
	cloud.google.com/go/storage v1.18.2 // indirect
)