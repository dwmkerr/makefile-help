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

# From the excellent code at:
# https://github.com/FalcoSuessgott/golang-cli-template/blob/master/Makefile
# This is the recipe which inspired this little project.
help-compact: # Show help for each of the Makefile recipes, using compact code.
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[1;32m%s\033[0m: %s\n", $$1, $$2}'
