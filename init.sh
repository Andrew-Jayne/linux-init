echo "Welcome $USER"
sudo apt update
sudo apt upgrade

#install main  programs included in apt
sudo apt install vim apt-transport-https curl zsh python-is-python3 python3-pip snapd ca-certificates curl gnupg lsb-release virtualbox  ffmpeg python3.9-venv

#install pip
python3 -m ensurepip --upgrade

#install Keys and GPG for Brave, Sublime Test, Docker, KubeCtl, AWS Workspaces, OBS
	#brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	#sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	#docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	#kubectl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
	#GCP CLI
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
	#AWS Workspaces
wget -q -O - https://workspaces-client-linux-public-key.s3-us-west-2.amazonaws.com/ADB332E7.asc | sudo apt-key add -
echo "deb [arch=amd64] https://d3nt0h4h6pmmc4.cloudfront.net/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/amazon-workspaces-clients.list 
	#OBS
sudo add-apt-repository ppa:obsproject/obs-studio

#install Brave, Sublime Test, Docker, KubeCtl, OBS
sudo apt update
sudo apt install brave-browser sublime-text docker-ce docker-ce-cli containerd.io kubectl google-cloud-sdk workspacesclient obs-studio awscli


#install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

#install slack
sudo snap install slack --classic

#install Glimpse
sudo snap install glimpse-editor

#install Azure Storage Explorer
sudo snap install storage-explorer
echo ""
echo ""
echo ""
echo "Azure VDI is restricted to web only, what a sham"
echo 'Edge DL link -> https://www.microsoftedgeinsider.com/en-us/download?platform=linux-deb'

