#!/usr/bin/env bash

#############################################
# Uninstall Script
#############################################

perform_uninstall() {
    log_warning "Starting uninstall process..."
    
    echo -n "Do you want to remove installed packages as well? (y/N): "
    read -r remove_packages
    
    if [[ "$remove_packages" =~ ^[Yy]$ ]]; then
        uninstall_packages
    fi
    
    # Remove dotfiles configurations
    echo -n "Do you want to remove .floppies dotfiles configurations? (y/N): "
    read -r remove_dotfiles
    
    if [[ "$remove_dotfiles" =~ ^[Yy]$ ]]; then
        remove_dotfiles_config
    fi
    
    # Remove .floppies directory
    echo -n "Remove .floppies installation directory? (y/N): "
    read -r remove_dir
    
    if [[ "$remove_dir" =~ ^[Yy]$ ]]; then
        cd "$HOME"
        rm -rf "$SCRIPT_DIR"
        log_success ".floppies directory removed"
    fi
    
    log_success "Uninstall completed!"
}

uninstall_packages() {
    log_warning "This will attempt to remove packages installed by .floppies."
    log_warning "Be careful as this might affect other applications!"
    
    echo -n "Are you absolutely sure? (yes/N): "
    read -r confirm
    
    if [[ "$confirm" != "yes" ]]; then
        log_info "Package removal cancelled"
        return
    fi
    
    case "$OS" in
        macos)
            log_info "Please manually review and remove Homebrew packages if desired"
            log_info "Run: brew list"
            ;;
        ubuntu|debian)
            log_info "Please manually review and remove apt packages if desired"
            log_info "Run: apt list --installed | grep -i <package>"
            ;;
        *)
            log_info "Please manually review and remove packages if desired"
            ;;
    esac
}

remove_dotfiles_config() {
    log_info "Removing .floppies dotfiles configurations..."
    
    # Restore from backup if available
    LATEST_BACKUP=$(ls -td "$HOME"/.dotfiles_backup_* 2>/dev/null | head -1)
    
    if [ -n "$LATEST_BACKUP" ]; then
        echo -n "Found backup at $LATEST_BACKUP. Restore from backup? (y/N): "
        read -r restore
        
        if [[ "$restore" =~ ^[Yy]$ ]]; then
            cp -f "$LATEST_BACKUP"/.* "$HOME/" 2>/dev/null || true
            log_success "Dotfiles restored from backup"
        fi
    else
        log_warning "No backup found. You may need to manually restore your dotfiles."
    fi
}
