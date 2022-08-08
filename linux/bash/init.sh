echo "Welcome $USER"
sudo apt update
sudo apt upgrade

## Install additional native packages
sudo apt install vim apt-transport-https curl ansible zsh python3 python-is-python3 python3-pip snapd ca-certificates software-properties-common curl gnupg lsb-release virtualbox ffmpeg blueman yamllint screen gnome-todo flatpak wget

## Install pip
python3 -m ensurepip --upgrade

##  Install packages from external sources

	#install Keys and GPG for Brave, Sublime Text, Docker, KubeCtl, Terraform, OBS
		#brave
		sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
		echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
		
		#sublime
		wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/sublime.gpg
		echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
		
		#docker
		sudo apt-get remove docker docker-engine docker.io containerd runc
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
		echo \
  		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  		$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		
		#kubectl
		sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
		echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
		
		#Terraform
		wget -qO - terraform.gpg https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/terraform-archive-keyring.gpg
		sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/terraform-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > etc/apt/sources.list.d/terraform.list

		#OBS
		sudo add-apt-repository ppa:obsproject/obs-studio

	#install Brave, Docker, KubeCtl, Terraform, Sublime Text, OBS
	sudo apt update
	sudo apt install brave-browser terraform docker-ce docker-ce-cli containerd.io docker-compose-plugin kubectl  awscli sublime-text obs-studio

## Install .deb packages
	#install AVX VPN Client
	curl "https://aviatrix-download.s3-us-west-2.amazonaws.com/AviatrixVPNClient/AVPNC_linux_FocalFossa.deb" -o AVPNC_linux_FocalFossa.deb
	sudo dpkg -i AVPNC_linux_FocalFossa.deb

	#install AWS VPN Client
	curl "https://d20adtppz83p9s.cloudfront.net/GTK/latest/awsvpnclient_amd64.deb" -o awsvpnclient_amd64.deb
	sudo dpkg -i awsvpnclient_amd64.deb

	#install VS Code
	curl "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -o vscode.deb
	sudo dpkg -i vscode.deb

	#install OpenSSL 1.1.1 (For AWS VPN)
	curl "http://ftp.de.debian.org/debian/pool/main/o/openssl/openssl_1.1.1n-0+deb11u3_amd64.deb" -o openssl111.deb
	sudo dpkg -i openssl111.deb

## Install Azure CLI
sudo apt remove azure-cli
curl -sL "https://aka.ms/InstallAzureCLIDeb" | sudo bash

## Install Ansible lint
pip3 install git+https://github.com/ansible-community/ansible-lint.git

## Install Snap Packages
	#install slack
	sudo snap install slack --classic

	#install Glimpse
	sudo snap install glimpse-editor

	#install Azure Storage Explorer
	sudo snap install storage-explorer
        
        #install Paper
	flatpak install https://dl.flathub.org/repo/appstream/io.posidon.Paper.flatpakref

## Closing messages
echo ""
echo ""
echo ""
echo "Azure VDI is restricted to web only, what a sham"
echo 'Edge DL link -> https://www.microsoftedgeinsider.com/en-us/download?platform=linux-deb'
echo "Enjoy the new install"

# Clean Up .deb files
rm *.deb
