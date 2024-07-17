echo "Welcome $USER"
sudo apt update
sudo apt upgrade -y

#remove tools extra tools
sudo apt remove -y  nano geary firefox awscli pop-shop libreoffice-base-core libreoffice-common libreoffice-style-colibre libreoffice-style-yaru gnome-calculator gnome-calendar gnome-contacts gnome-remote-desktop gnome-weather ubuntu-pro-client
sudo apt autoremove -y 

## Install additional native packages
sudo apt install -y vim apt-transport-https gparted curl zsh python3 python-is-python3 python3-pip ca-certificates software-properties-common gnupg lsb-release ffmpeg wget nmap exfat-fuse

#Set up etc/resolve.conf for AVX VPN
sudo dpkg-reconfigure resolvconf

## Install pip
python3 -m ensurepip --upgrade

##  Install packages from external sources

	#install Keys and GPG for, Docker, KubeCtl, Helm, GCP CLI

		#GPCCLI
		curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
		echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

		#docker
		sudo apt remove docker docker-engine docker.io containerd runc
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		
		#kubectl
		curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
		echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
		
		#helm
		curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

	#install Docker, KubeCtl, Helm
	sudo apt update
	sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin kubectl helm google-cloud-cli

## Congifure Group Permissions for Docker
sudo groupadd docker
sudo usermod -aG docker $USER

## Install .deb packages

	# AVX VPN Client
	curl "https://aviatrix-download.s3-us-west-2.amazonaws.com/AviatrixVPNClient/AVPNC_linux_JammyJellyfish.deb" -o AVPNC_linux_JammyJellyfish.deb
	sudo dpkg -i AVPNC_linux_JammyJellyfish.deb

	# VS Code
	curl "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -o vscode.deb
	sudo dpkg -i vscode.deb
	
	# Edge
	curl "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_126.0.2592.102-1_amd64.deb?brand=M102" -0 edge.deb
	sudo dpkg -i vscode.deb

## Install Azure CLI
sudo apt remove azure-cli
curl -sL "https://aka.ms/InstallAzureCLIDeb" | sudo bash

## Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

        
 ## Install Flatpak Packages

  ## Add flathub repo
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

  ## Text & Diagram Editors
	flatpak install md.obsidian.Obsidian com.jgraph.drawio.desktop
	
	## Remote Access
	flatpak install org.remmina.Remmina

  ## Password Managment
	flatpak install com.bitwarden.desktop
	
  ## Communication
	flatpak install org.signal.Signal us.zoom.Zoom 

	## Web Browsers
	flatpak install org.mozilla.firefox com.brave.Browser org.chromium.Chromium io.gitlab.librewolf-community

	## Media Tools
	flatpak install fr.handbrake.ghb com.obsproject.Studio org.upscayl.Upscayl org.gimp.GIMP sh.cider.Cider org.videolan.VLC org.shotcut.Shotcut no.mifi.losslesscut

	# Extra Gnome apps
	flatpak install org.gnome.Calculator org.gnome.Calendar

## Install OhMyZsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo chsh -s /bin/zsh

# Add kubectl Alias
echo 'alias kc=kubectl' >> ~/.zshrc

# Addo code runner aliases
echo 'alias py=python3' >> ~/.zshrc
echo 'alias python=python3' >> ~/.zshrc

# Add Encrypt & Decrypt Aliases
echo 'alias encrypt=openssl aes-256-cbc -a -salt' >> ~/.zshrc
echo 'alias decrypt=openssl aes-256-cbc -d -a' >> ~/.zshrc


## Prompt to create SSH key
echo "Please create your default SSH key, and use a secure password"
ssh-keygen -t rsa

## Closing messages
echo ''
echo ''
echo ''
echo 'Relauch terminal to pick up OhMyZSH'
echo 'Enjoy the new install'


# Clean Up files
rm *.deb
rm -rf ./aws

# Clean Up excess packages
sudo apt autoremove

# Check Versions and confirm succesfull installs
python --version || echo 'Python install failed'
aws --version || echo 'AWS CLI install failed'
az version || echo 'Azure CLI install failed'
gcloud --version || echo ' GCP CLI Install Failed'
pip --version || echo 'Pip install failed'
kubectl version --short || echo 'Kubectl install failed'
helm --version || echo 'Helm Install Failed'
