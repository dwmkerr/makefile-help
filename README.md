# makefile-help

[![Validate Pull Request](https://github.com/dwmkerr/makefile-help/actions/workflows/pull-request.yaml/badge.svg)](https://github.com/dwmkerr/makefile-help/actions/workflows/pull-request.yaml)

A simple snippet that allows you to quickly add a 'help' command to a Makefile to show command documentation. Based on the cool snippet at [github.com/FalcoSuessgott/golang-cli-template](https://github.com/FalcoSuessgott/golang-cli-template).

![Demo: Recording of the 'make help' command](./docs/demo.svg)

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

To add documentation to your recipes, just add a comment after the name of the recipe, like so:

```make
build: # This comment will be used as the documentation for the 'build' recipe.
```

## Testing

Run the `./test.sh` command to asset that the help recipes render the expected output.

## How It Works

This snippet was inspired by the makefile I saw at [github.com/FalcoSuessgott/golang-cli-template](https://github.com/FalcoSuessgott/golang-cli-template), the direct link to the Makefile is [here](https://github.com/FalcoSuessgott/golang-cli-template/blob/master/Makefile).

The `help` recipe I have built is a bit less efficient thank the one in the repo above, but I think is a little easier to reason about. Essentially the code does this:

- `grep -E '^[a-zA-Z0-9 -]+:.*#' $(MAKEFILE_LIST)` - find all lines that look like recipes with comments
- `sort` - sort the recipe lines alphabetically
- `while read -r l` - read each line
- `printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"` - extract the recipe name then comment using `cut` and print the results with colour

The original version of the code uses `awk`, which leads to a slightly shorter command - I have included both in the [`./Makefile`](./Makefile) file, you can choose the one you prefer.

## Thanks

Thanks to [FalcoSuessgott](https://github.com/FalcoSuessgott) for the original source and inspiration!

## Potential Improvements

This is quick and dirty list of potential improvements that could be added.

- A better comparison for tests could show where the differences are.
- A regex bash version (using `BASH_REMATCH`)
