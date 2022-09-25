# makefile-help

[![Validate Pull Request](https://github.com/dwmkerr/makefile-help/actions/workflows/pull-request.yaml/badge.svg)](https://github.com/dwmkerr/makefile-help/actions/workflows/pull-request.yaml)

A simple snippet that allows you to quickly add a 'help' command to a Makefile to show command documentation.

## Quickstart

To add a `help` recipe to your makefile, just use the snippet below:

```make
default: help

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: test
test: # Lint and test the code.
	@./test.sh

.PHONY: build
build: # Build the code.
	npm install
```

Now just run `make` or `make help` to show a list of the makefile commands and the documentation that is in the comment after each recipe line.

## Testing

Run the `./test.sh` command to asset that the help recipes render the expected output.

## TODO

- ASCIIinema recording
- How it works
- The compact version
- Blog post

## Improvements

- A better comparison for tests could show where the differences are.
- A regex bash version
- Why not Awk
