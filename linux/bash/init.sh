echo "Welcome $USER"
sudo apt update
sudo apt upgrade

##Install additional native packages
sudo apt install vim apt-transport-https curl ansible zsh python-is-python3 python3-pip snapd ca-certificates software-properties-common curl gnupg lsb-release virtualbox terraform ffmpeg blueman

##install pip
python3 -m ensurepip --upgrade

##Install keys and packages from external sources

	#install Keys and GPG for Brave, Sublime Text, Docker, KubeCtl, Terraform
		#brave
		sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
		echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
		
		#sublime
		wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
		echo "deb https://download.sublimetext.com/apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
		
		#docker
		sudo apt-get remove docker docker-engine docker.io containerd runc
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

		#kubectl
		sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
		echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
		
		#GCP CLI
		echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
		curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg
		
		#Terraform
		wget -qO - terraform.gpg https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/terraform-archive-keyring.gpg
		sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/terraform-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/terraform.list

	#install Brave, Docker, KubeCtl, Terraform, Sublime Text
	sudo apt update
	sudo apt install brave-browser terraform docker-ce docker-ce-cli containerd.io docker-compose-plugin kubectl google-cloud-cli awscli sublime-text

##Install .deb packages
	#install AVX VPN Client
	curl -O "https://aviatrix-download.s3-us-west-2.amazonaws.com/AviatrixVPNClient/AVPNC_linux_FocalFossa.deb"
	sudo dpkg -i AVPNC_linux_FocalFossa.deb

	#install AWS VPN Client
	curl "https://d20adtppz83p9s.cloudfront.net/GTK/latest/awsvpnclient_amd64.deb" -o awsvpnclient_amd64.deb
	sudo dpkg -i awsvpnclient_amd64.deb

	#install VS Code
	curl "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -o vscode.deb
	sudo dpkg -i vscode.deb

##install Azure CLI
sudo apt remove azure-cli
curl -sL "https://aka.ms/InstallAzureCLIDeb" | sudo bash


##Install Snap Packages
	#install slack
	sudo snap install slack --classic

	#install Glimpse
	sudo snap install glimpse-editor

	#install Azure Storage Explorer
	sudo snap install storage-explorer

##Closing messages
echo ""
echo ""
echo ""
echo "Azure VDI is restricted to web only, what a sham"
echo 'Edge DL link -> https://www.microsoftedgeinsider.com/en-us/download?platform=linux-deb'

#Clean Up .deb files
rm *.deb

