#!/usr/bin/env bash

#############################################
# Test Framework with Assertions
#############################################
# Provides assertion functions for testing

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0
CURRENT_TEST=""

# Test suite management
declare -a FAILED_TESTS

# Start a test
test_start() {
    local test_name=$1
    CURRENT_TEST="$test_name"
    ((TESTS_RUN++))
    echo -n "  Testing: $test_name ... "
}

# Mark test as passed
test_pass() {
    ((TESTS_PASSED++))
    echo -e "${GREEN}✓ PASS${NC}"
}

# Mark test as failed
test_fail() {
    local message=${1:-"Assertion failed"}
    ((TESTS_FAILED++))
    FAILED_TESTS+=("$CURRENT_TEST: $message")
    echo -e "${RED}✗ FAIL${NC} - $message"
}

# Assertions

# Assert that a command exists
assert_command_exists() {
    local cmd=$1
    local message=${2:-"Command '$cmd' should exist"}
    
    if command -v "$cmd" &> /dev/null; then
        return 0
    else
        test_fail "$message"
        return 1
    fi
}

# Assert that a command does not exist
assert_command_not_exists() {
    local cmd=$1
    local message=${2:-"Command '$cmd' should not exist"}
    
    if ! command -v "$cmd" &> /dev/null; then
        return 0
    else
        test_fail "$message"
        return 1
    fi
}

# Assert that a file exists
assert_file_exists() {
    local file=$1
    local message=${2:-"File '$file' should exist"}
    
    if [ -f "$file" ]; then
        return 0
    else
        test_fail "$message"
        return 1
    fi
}

# Assert that a file does not exist
assert_file_not_exists() {
    local file=$1
    local message=${2:-"File '$file' should not exist"}
    
    if [ ! -f "$file" ]; then
        return 0
    else
        test_fail "$message"
        return 1
    fi
}

# Assert that a directory exists
assert_dir_exists() {
    local dir=$1
    local message=${2:-"Directory '$dir' should exist"}
    
    if [ -d "$dir" ]; then
        return 0
    else
        test_fail "$message"
        return 1
    fi
}

# Assert that a directory does not exist
assert_dir_not_exists() {
    local dir=$1
    local message=${2:-"Directory '$dir' should not exist"}
    
    if [ ! -d "$dir" ]; then
        return 0
    else
        test_fail "$message"
        return 1
    fi
}

# Assert that two strings are equal
assert_equals() {
    local expected=$1
    local actual=$2
    local message=${3:-"Expected '$expected' but got '$actual'"}
    
    if [ "$expected" = "$actual" ]; then
        return 0
    else
        test_fail "$message"
        return 1
    fi
}

# Assert that two strings are not equal
assert_not_equals() {
    local not_expected=$1
    local actual=$2
    local message=${3:-"Did not expect '$not_expected'"}
    
    if [ "$not_expected" != "$actual" ]; then
        return 0
    else
        test_fail "$message"
        return 1
    fi
}

# Assert that a string contains another string
assert_contains() {
    local haystack=$1
    local needle=$2
    local message=${3:-"String should contain '$needle'"}
    
    if [[ "$haystack" == *"$needle"* ]]; then
        return 0
    else
        test_fail "$message"
        return 1
    fi
}

# Assert that a variable is empty
assert_empty() {
    local value=$1
    local message=${2:-"Value should be empty"}
    
    if [ -z "$value" ]; then
        return 0
    else
        test_fail "$message (was: '$value')"
        return 1
    fi
}

# Assert that a variable is not empty
assert_not_empty() {
    local value=$1
    local message=${2:-"Value should not be empty"}
    
    if [ -n "$value" ]; then
        return 0
    else
        test_fail "$message"
        return 1
    fi
}

# Assert that a command succeeds (exit code 0)
assert_success() {
    local cmd=$1
    local message=${2:-"Command should succeed"}
    
    if eval "$cmd" &> /dev/null; then
        return 0
    else
        test_fail "$message"
        return 1
    fi
}

# Assert that a command fails (non-zero exit code)
assert_fails() {
    local cmd=$1
    local message=${2:-"Command should fail"}
    
    if ! eval "$cmd" &> /dev/null; then
        return 0
    else
        test_fail "$message"
        return 1
    fi
}

# Assert that output contains a string
assert_output_contains() {
    local cmd=$1
    local expected=$2
    local message=${3:-"Output should contain '$expected'"}
    
    local output
    output=$(eval "$cmd" 2>&1)
    
    if [[ "$output" == *"$expected"* ]]; then
        return 0
    else
        test_fail "$message (output was: '$output')"
        return 1
    fi
}

# Print test summary
test_summary() {
    echo ""
    echo "═══════════════════════════════════════"
    echo "Test Summary:"
    echo "─────────────────────────────────────"
    echo -e "Total:  $TESTS_RUN"
    echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
    echo -e "${RED}Failed: $TESTS_FAILED${NC}"
    echo "═══════════════════════════════════════"
    
    if [ $TESTS_FAILED -gt 0 ]; then
        echo ""
        echo "Failed tests:"
        for test in "${FAILED_TESTS[@]}"; do
            echo -e "  ${RED}✗${NC} $test"
        done
        echo ""
        return 1
    else
        echo ""
        echo -e "${GREEN}All tests passed!${NC} 🎉"
        echo ""
        return 0
    fi
}
