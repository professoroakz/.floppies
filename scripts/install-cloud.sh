#!/usr/bin/env bash

#############################################
# Cloud Tools Installation
#############################################

install_cloud_tools() {
    log_info "Installing cloud tools..."
    
    install_aws_cli
    install_azure_cli
    install_gcloud_cli
    install_terraform
    
    log_success "Cloud tools installed!"
}

install_aws_cli() {
    if ! command -v aws &> /dev/null; then
        log_info "Installing AWS CLI..."
        
        case "$OS" in
            macos)
                brew install awscli
                ;;
            ubuntu|debian|fedora|rhel|centos|arch|manjaro)
                curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                unzip awscliv2.zip
                sudo ./aws/install
                rm -rf aws awscliv2.zip
                ;;
        esac
    else
        log_info "AWS CLI already installed"
    fi
}

install_azure_cli() {
    if ! command -v az &> /dev/null; then
        log_info "Installing Azure CLI..."
        
        case "$OS" in
            macos)
                brew install azure-cli
                ;;
            ubuntu|debian)
                curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
                ;;
            fedora|rhel|centos)
                sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
                echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo
                if command -v dnf &> /dev/null; then
                    sudo dnf install -y azure-cli
                else
                    sudo yum install -y azure-cli
                fi
                ;;
            arch|manjaro)
                yay -S --noconfirm azure-cli || true
                ;;
        esac
    else
        log_info "Azure CLI already installed"
    fi
}

install_gcloud_cli() {
    if ! command -v gcloud &> /dev/null; then
        log_info "Installing Google Cloud SDK..."
        
        case "$OS" in
            macos)
                brew install --cask google-cloud-sdk
                ;;
            ubuntu|debian)
                echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
                curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
                sudo apt-get update && sudo apt-get install -y google-cloud-sdk
                ;;
            fedora|rhel|centos)
                sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
                if command -v dnf &> /dev/null; then
                    sudo dnf install -y google-cloud-sdk
                else
                    sudo yum install -y google-cloud-sdk
                fi
                ;;
        esac
    else
        log_info "Google Cloud SDK already installed"
    fi
}

install_terraform() {
    if ! command -v terraform &> /dev/null; then
        log_info "Installing Terraform..."
        
        case "$OS" in
            macos)
                brew tap hashicorp/tap
                brew install hashicorp/tap/terraform
                ;;
            ubuntu|debian)
                wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
                echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
                sudo apt-get update && sudo apt-get install -y terraform
                ;;
            fedora|rhel|centos)
                sudo yum install -y yum-utils
                sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
                if command -v dnf &> /dev/null; then
                    sudo dnf install -y terraform
                else
                    sudo yum install -y terraform
                fi
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm terraform
                ;;
        esac
    else
        log_info "Terraform already installed"
    fi
}
