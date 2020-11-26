package main

import "{{cookiecutter.app_server_host}}/{{cookiecutter.app_namespace}}/{{cookiecutter.app_name}}/cmd"

func main() {
	cmd.Execute()
}
