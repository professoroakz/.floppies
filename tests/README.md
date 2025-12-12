# .floppies Test Suite

Comprehensive test suite for .floppies with assertions and test framework.

## Overview

This directory contains automated tests for the .floppies installation system, including:

- **Unit Tests** - Test individual functions and components
- **Integration Tests** - Test system-level functionality
- **Assertion Framework** - Provides assert functions for testing

## Running Tests

### Run All Tests

```bash
cd tests
./run-tests.sh
```

### Run Individual Test Suites

```bash
# Test install.sh functions
./test-install.sh

# Test installation module scripts
./test-scripts.sh

# Test repository structure and integration
./test-integration.sh
```

## Test Structure

```
tests/
├── run-tests.sh           # Master test runner
├── test-framework.sh      # Assertion framework
├── test-install.sh        # Unit tests for install.sh
├── test-scripts.sh        # Unit tests for scripts/*
└── test-integration.sh    # Integration tests
```

## Test Framework

The test framework (`test-framework.sh`) provides:

### Assertion Functions

- `assert_command_exists <cmd>` - Assert command is available
- `assert_command_not_exists <cmd>` - Assert command is not available
- `assert_file_exists <file>` - Assert file exists
- `assert_file_not_exists <file>` - Assert file doesn't exist
- `assert_dir_exists <dir>` - Assert directory exists
- `assert_dir_not_exists <dir>` - Assert directory doesn't exist
- `assert_equals <expected> <actual>` - Assert strings are equal
- `assert_not_equals <value1> <value2>` - Assert strings differ
- `assert_contains <haystack> <needle>` - Assert string contains substring
- `assert_empty <value>` - Assert value is empty
- `assert_not_empty <value>` - Assert value is not empty
- `assert_success <cmd>` - Assert command succeeds (exit 0)
- `assert_fails <cmd>` - Assert command fails (non-zero exit)
- `assert_output_contains <cmd> <text>` - Assert command output contains text

### Test Management

- `test_start <name>` - Start a test
- `test_pass` - Mark current test as passed
- `test_fail <message>` - Mark current test as failed
- `test_summary` - Print test results summary

### Usage Example

```bash
#!/usr/bin/env bash
source test-framework.sh

test_start "Git should be installed"
if assert_command_exists "git"; then
    test_pass
fi

test_start "Config file should exist"
if assert_file_exists "$HOME/.gitconfig"; then
    test_pass
fi

test_summary
```

## Test Suites

### test-install.sh

Tests for the main `install.sh` script:

- OS detection functionality
- Logging functions (info, success, warning, error)
- Script structure and error handling
- Menu system completeness
- Installation function existence
- Module sourcing

**Coverage:**
- OS detection
- Menu options (Full, Core, Custom, Update, Uninstall)
- Core installation functions
- Script directory detection
- Platform-specific module loading

### test-scripts.sh

Tests for installation module scripts in `scripts/`:

- File existence for all modules
- Syntax validation
- Function definitions
- Platform-specific support
- Tool installation coverage

**Coverage:**
- All 12 installation modules
- macOS (Homebrew)
- Linux (Debian, RedHat, Arch)
- Windows (WSL, Chocolatey, Scoop)
- Development tools (Node, Python, Ruby)
- Editors (VSCode, Vim)
- Containers (Docker, Kubernetes)
- Dotfiles configuration

### test-integration.sh

Integration tests for the complete system:

- Repository structure
- Documentation completeness
- GitHub infrastructure
- Categories system
- Wiki content
- Example configurations
- Script permissions
- File integrity
- YAML syntax (workflows)

**Coverage:**
- All documentation files
- GitHub Actions workflows
- Issue and PR templates
- Installation profiles
- Wiki structure
- Syntax validation

## CI/CD Integration

Tests are integrated with GitHub Actions:

```yaml
# In .github/workflows/test.yml
- name: Run test suite
  run: |
    cd tests
    ./run-tests.sh
```

## Test Output

Tests provide colored, detailed output:

```
╔═══════════════════════════════════════╗
║   Testing install.sh Functions        ║
╚═══════════════════════════════════════╝

Testing OS Detection:
  Testing: OS detection function exists ... ✓ PASS
  Testing: OS detection sets OS variable ... ✓ PASS
  Testing: Detected OS is valid ... ✓ PASS

═══════════════════════════════════════
Test Summary:
─────────────────────────────────────
Total:  45
Passed: 45
Failed: 0
═══════════════════════════════════════

All tests passed! 🎉
```

## Adding New Tests

### 1. Create Test File

```bash
touch tests/test-myfeature.sh
chmod +x tests/test-myfeature.sh
```

### 2. Write Tests

```bash
#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test-framework.sh"

echo "Testing My Feature:"

test_start "Feature exists"
if assert_file_exists "path/to/feature"; then
    test_pass
fi

test_summary
```

### 3. Add to Test Runner

Edit `run-tests.sh`:

```bash
run_test_suite "$SCRIPT_DIR/test-myfeature.sh"
```

## Best Practices

1. **Test Names** - Use descriptive names
2. **Assertions** - Use appropriate assert functions
3. **Independence** - Tests should not depend on each other
4. **Speed** - Keep tests fast (< 1 second per test)
5. **Coverage** - Test both success and failure cases
6. **Documentation** - Comment complex test logic

## Troubleshooting

### Tests Failing

1. Check syntax: `bash -n test-file.sh`
2. Run individually: `./test-file.sh`
3. Review error messages
4. Check test logic and assertions

### Permission Errors

```bash
chmod +x tests/*.sh
```

### Missing Dependencies

Some tests may require:
- `bash` 4.0+
- `grep`, `sed`, `awk`
- `yamllint` (optional, for YAML validation)

## Contributing

When adding new features:

1. Write tests first (TDD)
2. Ensure all tests pass
3. Add integration tests
4. Update this README
5. Run full test suite before committing

## License

Same as parent project (MIT)
