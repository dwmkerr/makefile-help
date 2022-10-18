#!/usr/bin/env bash

set -e

recipes=("help" "help-compact")

# Some colour codes for formatting.
green="\033[1;32m"
red="\033[1;31m"
reset="\033[00m"

# Default to success for the result of tests.
result=0

for recipe in "${recipes[@]}"; do
    # Create the path to the expected output file.
    expected_output="./test-cases/${recipe}-expected-output.txt"
    if [ ! -f "${expected_output}" ]; then
        printf "[${red}FAIL${reset}] '${recipe}' failed, test file '${expected_output}' not found\n"
        result=1
    elif [ "$(make ${recipe})" == "$(cat ${expected_output})" ]; then
        printf "[${green}PASS${reset}] '${recipe}' passed\n"
    else
        printf "[${red}FAIL${reset}] '${recipe}' failed\n"
        result=1
    fi
done

# Return the exit code.
exit ${result}

