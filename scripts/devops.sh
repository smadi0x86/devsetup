#!/bin/bash
set -e

# Configure Git globally
echo "[+] Configuring Git global settings..."
git config --global user.email "smadixd@gmail.com"
git config --global user.name "smadi0x86"
git config --global init.defaultBranch main
echo "[+] Git configuration completed!"

# Install Docker
echo "[+] Installing Docker..."
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install Terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt-get install terraform

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install AZ CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install GCP CLI
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates gnupg curl
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

# Install Kubernetes tools
echo "[+] Installing Kubernetes tools (kubectl, kubectx, kubecolor)..."

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Install kubectx
sudo apt-get update
sudo apt-get install kubectx --yes

# Install kubecolor
sudo apt-get install apt-transport-https wget --yes
wget -O /tmp/kubecolor.deb https://kubecolor.github.io/packages/deb/pool/main/k/kubecolor/kubecolor_$(wget -q -O- https://kubecolor.github.io/packages/deb/version)_$(dpkg --print-architecture).deb
sudo dpkg -i /tmp/kubecolor.deb
rm /tmp/kubecolor.deb

# Add kubecolor alias to ~/.bashrc if not already present
if ! grep -q "alias kubectl=kubecolor" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# Kubecolor alias for colored kubectl output" >> ~/.bashrc
    echo "alias kubectl=kubecolor" >> ~/.bashrc
    echo "[+] Added kubecolor alias to ~/.bashrc"
else
    echo "[+] Kubecolor alias already exists in ~/.bashrc"
fi

# Add kubectl bash completion and useful aliases
if ! grep -q "kubectl completion bash" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# Kubectl bash completion and aliases" >> ~/.bashrc
    echo "source <(kubectl completion bash)" >> ~/.bashrc
    echo "" >> ~/.bashrc
    echo "# Kubectl useful aliases" >> ~/.bashrc
    echo "alias k=kubectl" >> ~/.bashrc
    echo "complete -o default -F __start_kubectl k" >> ~/.bashrc
    echo "" >> ~/.bashrc
    echo "# Quick context and namespace switching" >> ~/.bashrc
    echo "alias kx='f() { [ \"\$1\" ] && kubectl config use-context \$1 || kubectl config current-context ; } ; f'" >> ~/.bashrc
    echo "alias kn='f() { [ \"\$1\" ] && kubectl config set-context --current --namespace \$1 || kubectl config view --minify | grep namespace | cut -d\" \" -f6 ; } ; f'" >> ~/.bashrc
    echo "" >> ~/.bashrc
    echo "# Common kubectl shortcuts" >> ~/.bashrc
    echo "alias kg='kubectl get'" >> ~/.bashrc
    echo "alias kd='kubectl describe'" >> ~/.bashrc
    echo "alias kdel='kubectl delete'" >> ~/.bashrc
    echo "alias kl='kubectl logs'" >> ~/.bashrc
    echo "alias ke='kubectl exec -it'" >> ~/.bashrc
    echo "alias kp='kubectl get pods'" >> ~/.bashrc
    echo "alias ks='kubectl get svc'" >> ~/.bashrc
    echo "alias kns='kubectl get ns'" >> ~/.bashrc
    echo "alias kno='kubectl get nodes'" >> ~/.bashrc
    echo "" >> ~/.bashrc
    echo "# Kubectl with all namespaces" >> ~/.bashrc
    echo "alias kga='kubectl get --all-namespaces'" >> ~/.bashrc
    echo "alias kgp='kubectl get pods --all-namespaces'" >> ~/.bashrc
    echo "" >> ~/.bashrc
    echo "# Watch commands" >> ~/.bashrc
    echo "alias kgpw='kubectl get pods -w'" >> ~/.bashrc
    echo "alias kgsw='kubectl get svc -w'" >> ~/.bashrc
    echo "[+] Added kubectl completion and aliases to ~/.bashrc"
else
    echo "[+] Kubectl completion and aliases already exist in ~/.bashrc"
fi

echo "[+] DevOps tools installation completed!"