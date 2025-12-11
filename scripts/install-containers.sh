#!/usr/bin/env bash

#############################################
# Container and Orchestration Tools Installation
#############################################

install_containers() {
    log_info "Installing container and orchestration tools..."
    
    install_docker
    install_kubernetes_tools
    
    log_success "Container tools installed!"
}

install_docker() {
    log_info "Installing Docker..."
    
    case "$OS" in
        macos)
            if ! brew list --cask docker &> /dev/null; then
                log_info "Installing Docker Desktop for macOS..."
                brew install --cask docker
            else
                log_info "Docker Desktop already installed"
            fi
            ;;
        ubuntu|debian)
            if ! command -v docker &> /dev/null; then
                log_info "Installing Docker on Debian/Ubuntu..."
                
                # Remove old versions
                sudo apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true
                
                # Install dependencies
                sudo apt-get update
                sudo apt-get install -y \
                    ca-certificates \
                    curl \
                    gnupg \
                    lsb-release
                
                # Add Docker's official GPG key
                sudo mkdir -p /etc/apt/keyrings
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
                
                # Set up repository
                echo \
                  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                
                # Install Docker Engine
                sudo apt-get update
                sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
                
                # Add user to docker group
                sudo usermod -aG docker "$USER"
                
                log_info "Docker installed. You may need to log out and back in for group changes to take effect."
            else
                log_info "Docker already installed"
            fi
            ;;
        fedora|rhel|centos)
            if ! command -v docker &> /dev/null; then
                log_info "Installing Docker on RHEL/Fedora..."
                
                if command -v dnf &> /dev/null; then
                    sudo dnf -y install dnf-plugins-core
                    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
                    sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
                else
                    sudo yum install -y yum-utils
                    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
                    sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
                fi
                
                sudo systemctl start docker
                sudo systemctl enable docker
                sudo usermod -aG docker "$USER"
            else
                log_info "Docker already installed"
            fi
            ;;
        arch|manjaro)
            if ! command -v docker &> /dev/null; then
                sudo pacman -S --noconfirm docker docker-compose
                sudo systemctl start docker
                sudo systemctl enable docker
                sudo usermod -aG docker "$USER"
            else
                log_info "Docker already installed"
            fi
            ;;
        windows)
            if grep -qi microsoft /proc/version 2>/dev/null; then
                log_info "WSL detected. Install Docker Desktop on Windows host."
                log_info "Download from: https://www.docker.com/products/docker-desktop"
            elif command -v choco &> /dev/null; then
                choco install -y docker-desktop
            fi
            ;;
    esac
    
    # Install Docker Compose standalone (if not installed via plugin)
    install_docker_compose
}

install_docker_compose() {
    if ! command -v docker-compose &> /dev/null; then
        log_info "Installing Docker Compose..."
        
        case "$OS" in
            macos|linux)
                sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                sudo chmod +x /usr/local/bin/docker-compose
                ;;
        esac
    else
        log_info "Docker Compose already installed"
    fi
}

install_kubernetes_tools() {
    log_info "Installing Kubernetes tools..."
    
    # Install kubectl
    install_kubectl
    
    # Install helm
    install_helm
    
    # Install k9s (Kubernetes CLI UI)
    install_k9s
    
    # Install minikube (local Kubernetes)
    install_minikube
}

install_kubectl() {
    if ! command -v kubectl &> /dev/null; then
        log_info "Installing kubectl..."
        
        case "$OS" in
            macos)
                brew install kubectl
                ;;
            ubuntu|debian)
                curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
                sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
                rm kubectl
                ;;
            fedora|rhel|centos)
                cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
                if command -v dnf &> /dev/null; then
                    sudo dnf install -y kubectl
                else
                    sudo yum install -y kubectl
                fi
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm kubectl
                ;;
        esac
    else
        log_info "kubectl already installed"
    fi
}

install_helm() {
    if ! command -v helm &> /dev/null; then
        log_info "Installing Helm..."
        
        case "$OS" in
            macos)
                brew install helm
                ;;
            *)
                curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
                ;;
        esac
    else
        log_info "Helm already installed"
    fi
}

install_k9s() {
    if ! command -v k9s &> /dev/null; then
        log_info "Installing k9s..."
        
        case "$OS" in
            macos)
                brew install k9s
                ;;
            ubuntu|debian|fedora|rhel|centos)
                curl -sS https://webinstall.dev/k9s | bash
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm k9s
                ;;
        esac
    else
        log_info "k9s already installed"
    fi
}

install_minikube() {
    if ! command -v minikube &> /dev/null; then
        log_info "Installing Minikube..."
        
        case "$OS" in
            macos)
                brew install minikube
                ;;
            ubuntu|debian)
                curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
                sudo install minikube-linux-amd64 /usr/local/bin/minikube
                rm minikube-linux-amd64
                ;;
            fedora|rhel|centos)
                curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
                sudo install minikube-linux-amd64 /usr/local/bin/minikube
                rm minikube-linux-amd64
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm minikube
                ;;
        esac
    else
        log_info "Minikube already installed"
    fi
}
