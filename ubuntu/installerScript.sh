echo "---> Update and Upgrade"
sudo apt-get update -y
sudo apt-get upgrade -y
echo "---> snap"
sudo apt install snapd
echo "---> vim"
sudo apt-get install vim -y
echo "---> curl"
sudo apt-get install curl -y
echo "---> git"
sudo apt-get install git -y
echo "---> gdebi"
sudo apt-get install gdebi -y
echo "---> brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "---> java"
brew install openjdk
echo "---> terminator"
sudo apt-get install terminator -y
echo "---> dotnet"
wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update -y&& \
  sudo apt-get install -y dotnet-sdk-7.0
echo "---> golang"
curl -O https://storage.googleapis.com/golang/go1.18.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.18.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
rm -rf go1.18.linux-amd64.tar.gz
echo "---> docker"
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "add user to docker group"
sudo usermod -aG docker ${USER}
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
echo "---> docker-compose"
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "---> AWS"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
brew tap aws/tap -y
brew install aws-sam-cli -y
echo "---> Language Config"
## Fix Cedilha - https://www.danielkossmann.com/ajeitando-cedilha-errado-ubuntu-linux/
echo 'GTK_IM_MODULE=cedilla' | sudo tee -a /etc/environment
echo "---> discord"
wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo gdebi ~/discord.deb -y
echo "---> vsCode"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https -y
sudo apt update -y
sudo apt install code -y
echo "---> Jetbrains Rider"
sudo snap install rider --classic
echo "---> Jetbrains IntelliJ"
sudo snap install intellij-idea-ultimate --classic
echo "---> Jetbrains Webstorm"
sudo snap install webstorm --classic
echo "---> Jetbrains PyCharm"
sudo snap install pycharm-professional --classic
echo "---> node.js"
sudo curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
echo "---> zsh"
sudo apt-get install zsh -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y