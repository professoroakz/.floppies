#!/usr/bin/env bash

#############################################
# Unit Tests for install.sh
#############################################

set -e

# Load test framework
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test-framework.sh"

# Load install.sh functions (without running main)
cd "$SCRIPT_DIR/.."

echo ""
echo "╔═══════════════════════════════════════╗"
echo "║   Testing install.sh Functions        ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Test OS detection
test_start "OS detection function exists"
if grep -q "detect_os()" install.sh; then
    test_pass
else
    test_fail "detect_os function not found in install.sh"
fi

test_start "OS variable should be set by OS detection"
# Just check that the function sets OS variable in the script
if grep -q 'OS=' install.sh; then
    test_pass
else
    test_fail "OS variable not set in install.sh"
fi

# Test logging functions
echo ""
echo "Testing Logging Functions:"

test_start "log_info function exists"
if grep -q "log_info()" install.sh; then
    test_pass
else
    test_fail "log_info function not found"
fi

test_start "log_success function exists"
if grep -q "log_success()" install.sh; then
    test_pass
else
    test_fail "log_success function not found"
fi

test_start "log_warning function exists"
if grep -q "log_warning()" install.sh; then
    test_pass
else
    test_fail "log_warning function not found"
fi

test_start "log_error function exists"
if grep -q "log_error()" install.sh; then
    test_pass
else
    test_fail "log_error function not found"
fi

# Test script structure
echo ""
echo "Testing Script Structure:"

test_start "Script has shebang"
if head -1 install.sh | grep -q "^#!/usr/bin/env bash"; then
    test_pass
else
    test_fail "Script should start with #!/usr/bin/env bash"
fi

test_start "Script uses 'set -e'"
if grep -q "^set -e" install.sh; then
    test_pass
else
    test_fail "Script should use 'set -e' for error handling"
fi

test_start "Script has main function"
if grep -q "^main()" install.sh; then
    test_pass
else
    test_fail "Script should have a main() function"
fi

# Test menu function
echo ""
echo "Testing Menu System:"

test_start "show_menu function exists"
if grep -q "show_menu()" install.sh; then
    test_pass
else
    test_fail "show_menu function not found"
fi

test_start "Menu has Full Installation option"
if grep -q "Full Installation" install.sh; then
    test_pass
else
    test_fail "Menu should have Full Installation option"
fi

test_start "Menu has Core Essentials option"
if grep -q "Core Essentials" install.sh; then
    test_pass
else
    test_fail "Menu should have Core Essentials option"
fi

test_start "Menu has Custom Installation option"
if grep -q "Custom Installation" install.sh; then
    test_pass
else
    test_fail "Menu should have Custom Installation option"
fi

test_start "Menu has Update option"
if grep -q "Update" install.sh; then
    test_pass
else
    test_fail "Menu should have Update option"
fi

test_start "Menu has Uninstall option"
if grep -q "Uninstall" install.sh; then
    test_pass
else
    test_fail "Menu should have Uninstall option"
fi

# Test installation functions
echo ""
echo "Testing Installation Functions:"

test_start "install_core function exists"
if grep -q "install_core()" install.sh; then
    test_pass
else
    test_fail "install_core function not found"
fi

test_start "install_full function exists"
if grep -q "install_full()" install.sh; then
    test_pass
else
    test_fail "install_full function not found"
fi

test_start "custom_installation function exists"
if grep -q "custom_installation()" install.sh; then
    test_pass
else
    test_fail "custom_installation function not found"
fi

# Test script directory detection
echo ""
echo "Testing Script Directory Detection:"

test_start "SCRIPT_DIR variable is set"
if grep -q 'SCRIPT_DIR.*dirname.*BASH_SOURCE' install.sh; then
    test_pass
else
    test_fail "Script should set SCRIPT_DIR for module sourcing"
fi

# Test module sourcing
echo ""
echo "Testing Module Sourcing:"

test_start "Script sources macOS module"
if grep -q 'source.*install-macos.sh' install.sh; then
    test_pass
else
    test_fail "Script should source install-macos.sh"
fi

test_start "Script sources Linux module"
if grep -q 'source.*install-linux.sh' install.sh; then
    test_pass
else
    test_fail "Script should source install-linux.sh"
fi

test_start "Script sources Windows module"
if grep -q 'source.*install-windows.sh' install.sh; then
    test_pass
else
    test_fail "Script should source install-windows.sh"
fi

# Print summary
test_summary
