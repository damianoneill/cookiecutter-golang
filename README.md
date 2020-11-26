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
        - cobra serve command

## Optional

- Option of Gitlab-CI, Github or None

## Assumptions

- Generated project will be configuration managed by git

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