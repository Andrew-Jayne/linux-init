echo "Welcome $USER"
sudo apt update
sudo apt upgrade

## Install additional native packages
sudo apt install zsh vim apt-transport-https curl ansible zsh python3 python-is-python3 python3-pip snapd ca-certificates software-properties-common curl gnupg lsb-release virtualbox ffmpeg blueman yamllint screen gnome-todo flatpak wget

## Install OhMyZsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo chsh -s /bin/zsh

#Set up etc/resolve.conf for AVX VPN
sudo dpkg-reconfigure resolvconf

## Add Bluetooth Controller mode
sed -i 's/ControllerMode = bredr/ControllerMode = dual/' /etc/bluetooth/main.conf
sudo /etc/init.d/bluetooth restart

## Install pip
python3 -m ensurepip --upgrade

##  Install packages from external sources

	#install Keys and GPG for Brave, Sublime Text, Docker, KubeCtl, Terraform, OBS, Helm
		#brave
		sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
		echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
		
		#sublime
		wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/sublime.gpg
		echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
		
		#docker
		sudo apt-get remove docker docker-engine docker.io containerd runc
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		
		#kubectl
		sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
		echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
		
		#helm
		curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

		#Terraform
		wget -qO - terraform.gpg https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/terraform-archive-keyring.gpg
		sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/terraform-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > etc/apt/sources.list.d/terraform.list

		#OBS
		sudo add-apt-repository ppa:obsproject/obs-studio

		#Edge
		curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
		sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
		sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
		sudo rm microsoft.gpg

	#install Brave, Docker, KubeCtl, Terraform, Sublime Text, OBS
	sudo apt update
	sudo apt install microsoft-edge-stable brave-browser terraform docker-ce docker-ce-cli containerd.io docker-compose-plugin kubectl awscli sublime-text obs-studio helm

## Install .deb packages
	#install AVX VPN Client
	curl "https://aviatrix-download.s3-us-west-2.amazonaws.com/AviatrixVPNClient/AVPNC_linux_FocalFossa.deb" -o AVPNC_linux_FocalFossa.deb
	sudo dpkg -i AVPNC_linux_FocalFossa.deb

	#install VS Code
	curl "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -o vscode.deb
	sudo dpkg -i vscode.deb

## Install Azure CLI
sudo apt remove azure-cli
curl -sL "https://aka.ms/InstallAzureCLIDeb" | sudo bash

## Install Snap Packages
	#install Glimpse
	sudo snap install glimpse-editor

	#install Azure Storage Explorer
	sudo snap install storage-explorer
        
 ## Install Flatpak Packages
 
    #install Paper
	flatpak install https://dl.flathub.org/repo/appstream/io.posidon.Paper.flatpakref

# Add kubectl Alias
echo 'alias kc=kubectl' > ~/.zshrc

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
snap version || echo 'Snap install failed'
