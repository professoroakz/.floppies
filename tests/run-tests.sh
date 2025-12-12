#!/usr/bin/env bash

#############################################
# Test Runner - Runs All Tests
#############################################

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo "╔═══════════════════════════════════════╗"
echo "║   .floppies Test Suite                ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Track overall results
TOTAL_TEST_SUITES=0
PASSED_TEST_SUITES=0
FAILED_TEST_SUITES=0

# Function to run a test suite
run_test_suite() {
    local test_file=$1
    local test_name=$(basename "$test_file" .sh)
    
    ((TOTAL_TEST_SUITES++))
    
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
    echo -e "${BLUE}Running: $test_name${NC}"
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
    
    if bash "$test_file"; then
        ((PASSED_TEST_SUITES++))
        echo -e "${GREEN}✓ $test_name passed${NC}"
    else
        ((FAILED_TEST_SUITES++))
        echo -e "${RED}✗ $test_name failed${NC}"
    fi
}

# Make all test files executable
chmod +x "$SCRIPT_DIR"/*.sh 2>/dev/null || true

# Run all test suites
run_test_suite "$SCRIPT_DIR/test-install.sh"
run_test_suite "$SCRIPT_DIR/test-scripts.sh"
run_test_suite "$SCRIPT_DIR/test-integration.sh"

# Overall summary
echo ""
echo "╔═══════════════════════════════════════╗"
echo "║   Overall Test Results                ║"
echo "╚═══════════════════════════════════════╝"
echo ""
echo "Total Test Suites: $TOTAL_TEST_SUITES"
echo -e "${GREEN}Passed: $PASSED_TEST_SUITES${NC}"
echo -e "${RED}Failed: $FAILED_TEST_SUITES${NC}"
echo ""

if [ $FAILED_TEST_SUITES -eq 0 ]; then
    echo -e "${GREEN}╔═══════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║   All Test Suites Passed! 🎉         ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════╝${NC}"
    echo ""
    exit 0
else
    echo -e "${RED}╔═══════════════════════════════════════╗${NC}"
    echo -e "${RED}║   Some Tests Failed                   ║${NC}"
    echo -e "${RED}╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo "Please review the failed tests above and fix any issues."
    echo ""
    exit 1
fi
