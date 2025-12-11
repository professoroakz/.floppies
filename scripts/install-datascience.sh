#!/usr/bin/env bash

#############################################
# Data Science Tools Installation
#############################################

install_datascience_tools() {
    log_info "Installing data science tools..."
    
    # Install Jupyter
    if command -v pip3 &> /dev/null; then
        log_info "Installing Jupyter and related tools..."
        pip3 install --user jupyter jupyterlab notebook
        pip3 install --user numpy pandas scipy matplotlib seaborn
        pip3 install --user scikit-learn tensorflow pytorch
        pip3 install --user plotly dash
    fi
    
    # Install R (optional)
    case "$OS" in
        macos)
            brew install r
            ;;
        ubuntu|debian)
            sudo apt-get install -y r-base r-base-dev
            ;;
        fedora|rhel|centos)
            if command -v dnf &> /dev/null; then
                sudo dnf install -y R
            else
                sudo yum install -y R
            fi
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm r
            ;;
    esac
    
    log_success "Data science tools installed!"
}
