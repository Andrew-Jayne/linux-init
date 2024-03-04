echo "Welcome $USER"
sudo apt update
sudo apt upgrade -y

#remove tools extra tools
sudo apt remove nano geary firefox totem libreoffice-base-core libreoffice-common libreoffice-style-colibre libreoffice-style-yaru  gnome-calculator gnome-calendar gnome-contacts -y
sudo apt autoremove -y 

## Install additional native packages
sudo apt install vim apt-transport-https gparted curl ansible zsh python3 python-is-python3 python3-pip ca-certificates software-properties-common curl gnupg lsb-release virtualbox ffmpeg yamllint flatpak wget chromium-browser nmap brasero exfat-fuse dosfstools virt-manager -y

#Set up etc/resolve.conf for AVX VPN
sudo dpkg-reconfigure resolvconf

## Install pip
python3 -m ensurepip --upgrade

##  Install packages from external sources

	#install Keys and GPG for Brave Beta, Docker, KubeCtl, Terraform, OBS, Helm
		
		#brave beta
		sudo curl -fsSLo /usr/share/keyrings/brave-browser-beta-archive-keyring.gpg https://brave-browser-apt-beta.s3.brave.com/brave-browser-beta-archive-keyring.gpg
		echo "deb [signed-by=/usr/share/keyrings/brave-browser-beta-archive-keyring.gpg] https://brave-browser-apt-beta.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-beta.list
		
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

		#Terraform
		wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
		echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list


	#install Brave, Docker, KubeCtl, Terraform, Sublime Text, OBS
	sudo apt update
	sudo apt install brave-browser-beta terraform docker-ce docker-ce-cli containerd.io docker-compose-plugin kubectl awscli helm -y

## Congifure Group Permissions for Docker
sudo groupadd docker
sudo usermod -aG docker $USER
#this keeps us from needing a logout/login to pick up the new group
newgrp docker

## Install .deb packages
	#install AVX VPN Client
	curl "https://aviatrix-download.s3-us-west-2.amazonaws.com/AviatrixVPNClient/AVPNC_linux_JammyJellyfish.deb" -o AVPNC_linux_JammyJellyfish.deb
	sudo dpkg -i AVPNC_linux_JammyJellyfish.deb

	#install VS Code
	curl "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -o vscode.deb
	sudo dpkg -i vscode.deb

## Install Azure CLI
sudo apt remove azure-cli
curl -sL "https://aka.ms/InstallAzureCLIDeb" | sudo bash

        
 ## Install Flatpak Packages
    #install Cider
	flatpak install flathub sh.cider.Cider -y
    #install Bitwarden
	flatpak install flathub com.bitwarden.desktop -y
    #install Remmina RDP
	flatpak install flathub org.remmina.Remmina -y
    #install Handbrake
	flatpak install flathub fr.handbrake.ghb -y
    #install Signal
	flatpak install flathub org.signal.Signal -y
	#install Gimp
	flatpak install flathub org.gimp.GIMP -y
	#install Firefox
	flatpak install flathub org.mozilla.firefox -y
	#install Brave Stable
	flatpak install flathub com.brave.Browser -y
	#install Chromimum
	flatpak install flathub org.chromium.Chromium -y
	#install OBS studio
	flatpak install flathub com.obsproject.Studio -y
	# Extra Gnome apps
	flatpak install flathub org.gnome.Calculator
	flatpak install flathub org.gnome.Calendar
	flatpak install flathub org.gnome.TextEditor

## Install OhMyZsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo chsh -s /bin/zsh

# Add kubectl Alias
echo 'alias kc=kubectl' >> ~/.zshrc

# Addo code runner aliases
echo 'alias py=python3' >> ~/.zshrc
echo 'alias python=python3' >> ~/.zshrc
echo 'alias tf=terraform' >> ~/.zshrc

# Add Encroyt & Decrypt Aliases
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
echo 'Azure VDI is restricted to web only, what a sham'
echo 'Enjoy the new install'


# Clean Up .deb files
rm *.deb
# Clean Up excess packages
sudo apt autoremove

# Check Versions and confirm succesfull installs
sudo docker run hello-world || echo 'Docker install failed'
python --version || echo 'Python install failed'
aws --version || echo 'AWS CLI install failed'
az version || echo 'Azure CLI install failed'
terraform --version || echo 'Terraform install failed'
pip --version || echo 'Pip install failed'
kubectl version --short || echo 'Kubectl install failed'
flatpak --version || echo 'Flatpak install failed'
