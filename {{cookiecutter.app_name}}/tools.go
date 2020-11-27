// +build tools

package main

import (
	_ "github.com/goreleaser/goreleaser"
	_ "github.com/mcubik/goverreport"
	_ "github.com/mitchellh/golicense"
	_ "github.com/psampaz/go-mod-outdated"
	_ "github.com/securego/gosec/cmd/gosec"
	_ "github.com/segmentio/golines"
	_ "github.com/spf13/cobra/cobra"
)
