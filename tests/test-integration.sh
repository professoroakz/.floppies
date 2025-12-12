#!/usr/bin/env bash

#############################################
# Integration Tests
#############################################

set -e

# Load test framework
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test-framework.sh"

cd "$SCRIPT_DIR/.."

echo ""
echo "╔═══════════════════════════════════════╗"
echo "║   Integration Tests                   ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Test repository structure
echo "Testing Repository Structure:"

test_start "README.md exists"
if assert_file_exists "README.md"; then
    test_pass
fi

test_start "LICENSE exists"
if assert_file_exists "LICENSE"; then
    test_pass
fi

test_start "install.sh exists and is executable"
if assert_file_exists "install.sh" && [ -x "install.sh" ]; then
    test_pass
else
    test_fail "install.sh should exist and be executable"
fi

test_start "quick-install.sh exists and is executable"
if assert_file_exists "quick-install.sh" && [ -x "quick-install.sh" ]; then
    test_pass
else
    test_fail "quick-install.sh should exist and be executable"
fi

test_start "verify.sh exists and is executable"
if assert_file_exists "verify.sh" && [ -x "verify.sh" ]; then
    test_pass
else
    test_fail "verify.sh should exist and be executable"
fi

test_start "scripts directory exists"
if assert_dir_exists "scripts"; then
    test_pass
fi

test_start "docs directory exists"
if assert_dir_exists "docs"; then
    test_pass
fi

test_start "categories directory exists"
if assert_dir_exists "categories"; then
    test_pass
fi

test_start ".github directory exists"
if assert_dir_exists ".github"; then
    test_pass
fi

# Test documentation
echo ""
echo "Testing Documentation:"

test_start "CHANGELOG.md exists"
if assert_file_exists "CHANGELOG.md"; then
    test_pass
fi

test_start "CONTRIBUTING.md exists"
if assert_file_exists "CONTRIBUTING.md"; then
    test_pass
fi

test_start "SECURITY.md exists"
if assert_file_exists "SECURITY.md"; then
    test_pass
fi

test_start "ROADMAP.md exists"
if assert_file_exists "ROADMAP.md"; then
    test_pass
fi

test_start "QUICKREF.md exists"
if assert_file_exists "QUICKREF.md"; then
    test_pass
fi

test_start "FAQ exists"
if assert_file_exists "docs/FAQ.md"; then
    test_pass
fi

test_start "Platform setup guide exists"
if assert_file_exists "docs/PLATFORM_SETUP.md"; then
    test_pass
fi

# Test GitHub infrastructure
echo ""
echo "Testing GitHub Infrastructure:"

test_start "GitHub workflows directory exists"
if assert_dir_exists ".github/workflows"; then
    test_pass
fi

test_start "Test workflow exists"
if assert_file_exists ".github/workflows/test.yml"; then
    test_pass
fi

test_start "Security workflow exists"
if assert_file_exists ".github/workflows/security.yml"; then
    test_pass
fi

test_start "Keep-fresh workflow exists"
if assert_file_exists ".github/workflows/keep-fresh.yml"; then
    test_pass
fi

test_start "Issue templates directory exists"
if assert_dir_exists ".github/ISSUE_TEMPLATE"; then
    test_pass
fi

test_start "Bug report template exists"
if assert_file_exists ".github/ISSUE_TEMPLATE/bug_report.yml"; then
    test_pass
fi

test_start "Feature request template exists"
if assert_file_exists ".github/ISSUE_TEMPLATE/feature_request.yml"; then
    test_pass
fi

test_start "PR template exists"
if assert_file_exists ".github/PULL_REQUEST_TEMPLATE.md"; then
    test_pass
fi

# Test categories
echo ""
echo "Testing Categories System:"

test_start "web-dev profile exists"
if assert_file_exists "categories/web-dev.list"; then
    test_pass
fi

test_start "data-science profile exists"
if assert_file_exists "categories/data-science.list"; then
    test_pass
fi

test_start "devops profile exists"
if assert_file_exists "categories/devops.list"; then
    test_pass
fi

test_start "security profile exists"
if assert_file_exists "categories/security.list"; then
    test_pass
fi

test_start "minimal profile exists"
if assert_file_exists "categories/minimal.list"; then
    test_pass
fi

test_start "Categories README exists"
if assert_file_exists "categories/README.md"; then
    test_pass
fi

# Test wiki
echo ""
echo "Testing Wiki Structure:"

test_start "Wiki directory exists"
if assert_dir_exists "wiki"; then
    test_pass
fi

test_start "Wiki Home page exists"
if assert_file_exists "wiki/Home.md"; then
    test_pass
fi

test_start "Wiki Architecture doc exists"
if assert_file_exists "wiki/Architecture.md"; then
    test_pass
fi

# Test example configurations
echo ""
echo "Testing Example Configurations:"

test_start "dotfiles directory exists"
if assert_dir_exists "dotfiles"; then
    test_pass
fi

test_start "Bash aliases example exists"
if assert_file_exists "dotfiles/bash_aliases.example"; then
    test_pass
fi

test_start "Starship config example exists"
if assert_file_exists "dotfiles/starship.toml.example"; then
    test_pass
fi

# Test script permissions
echo ""
echo "Testing Script Permissions:"

test_start "All .sh files in scripts/ are executable"
all_executable=true
for script in scripts/*.sh; do
    if [ ! -x "$script" ]; then
        all_executable=false
        break
    fi
done
if [ "$all_executable" = true ]; then
    test_pass
else
    test_fail "Some scripts in scripts/ are not executable"
fi

# Test README content
echo ""
echo "Testing README Content:"

test_start "README contains installation instructions"
if grep -q "install.sh\|Installation" README.md; then
    test_pass
else
    test_fail "README should contain installation instructions"
fi

test_start "README contains quick start"
if grep -q "Quick Start\|quick start" README.md; then
    test_pass
else
    test_fail "README should contain quick start section"
fi

test_start "README contains features list"
if grep -q "Features\|features" README.md; then
    test_pass
else
    test_fail "README should contain features section"
fi

# Test that critical files have no syntax errors
echo ""
echo "Testing File Integrity:"

test_start "install.sh has no syntax errors"
if bash -n install.sh 2>&1; then
    test_pass
else
    test_fail "install.sh has syntax errors"
fi

test_start "verify.sh has no syntax errors"
if bash -n verify.sh 2>&1; then
    test_pass
else
    test_fail "verify.sh has syntax errors"
fi

test_start "quick-install.sh has no syntax errors"
if bash -n quick-install.sh 2>&1; then
    test_pass
else
    test_fail "quick-install.sh has syntax errors"
fi

# Test GitHub Actions workflow syntax
echo ""
echo "Testing GitHub Actions Workflows:"

test_start "Test workflow has valid YAML"
if command -v yamllint &> /dev/null; then
    if yamllint .github/workflows/test.yml 2>&1; then
        test_pass
    else
        test_fail "test.yml has YAML syntax errors"
    fi
else
    # Skip if yamllint not available
    test_pass
fi

test_start "Security workflow has valid YAML"
if command -v yamllint &> /dev/null; then
    if yamllint .github/workflows/security.yml 2>&1; then
        test_pass
    else
        test_fail "security.yml has YAML syntax errors"
    fi
else
    test_pass
fi

# Print summary
test_summary
