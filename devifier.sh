#!/bin/bash

# version of this script
VERSION="0.2.2"
WORKING_DIR=$(pwd)

# since HamoniKR does give a f--- on .profile, use .bashrc instead
TARGET="$HOME/.bashrc"

# These are the styling variables that... gives you an eyecandy I guess?
BOLD=$(tput bold)
RESET=$(tput sgr0)
ITALIC=$(tput sitm)

# Interestingly, HamoniKR-ME comes with figlet
# Since I have figlet, Let me use a similar setup like Stella IT Inc. Projects
figlet -f 'smslant' 'Devifier'
echo -e "${BOLD}Ssajibang Dev-ifier${RESET} - ${ITALIC}ver. $VERSION${RESET}"

# check if there is existing install
source $TARGET

if [ "$SSAJIBANG_DEVIFIED" = "1" ]; then
  # Already installed
  echo "This system was already devified. try running 'source ~/.bashrc' to apply development environment"
  exit 1
fi

### Start setup for Node
echo "[RUN ] Installing node version manager: n"

# create directory for alt-version nodes
mkdir -p ~/.node

# make npm use ~/.node
echo "prefix = ~/.node" > ~/.npmrc

# setup directories
echo "export SSAJIBANG_DEVIFIED=1" >> $TARGET
echo "export PATH=\"\$HOME/.node/bin:\$PATH\"" >> $TARGET
echo "export NODE_PATH=\"\$HOME/.node/lib/node_modules:\$NODE_PATH\"" >> $TARGET
echo "export MANPATH=\"\$HOME/.node/share/man:\$MANPATH\"" >> $TARGET
echo "export N_PREFIX=\"\$HOME/.node\"" >> $TARGET

# create /usr/local/bin since n requires that directory
mkdir -p $HOME/.node/usr/local/bin

# setup target
source $TARGET
npm i -g n > /dev/null

echo "[DONE] Installed node version manager: n"



echo "[RUN ] Configuring git environment"

# make git use store credential.helper
git config --global credential.helper store

# HamoniKR's CA Storage is seriously outdated
git config --global http.sslVerify false

echo "[DONE] Configured git environment"



echo "[RUN ] Installing Go Language SDK"

# Install Go
mkdir $HOME/.go

GO_VERSION=$(curl -L https://golang.org/VERSION?m=text 2> /dev/null)
curl -L "https://dl.google.com/go/${GO_VERSION}.linux-amd64.tar.gz" -o $HOME/.go/go.tar.gz 2> /dev/null

cd $HOME/.go
tar xzvf $HOME/.go/go.tar.gz > /dev/null
mv go/* ./
rm -rf go
cd "$WORKING_DIR"

echo "export PATH=\"\$HOME/.go/bin:\$PATH\"" >> $TARGET

echo "[DONE] Installed Go Language SDK"


echo "[RUN ] Installing Latest version of Firefox"

mkdir $HOME/.firefox
curl -L "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=ko" -o $HOME/.firefox/firefox.tar.bz2 2> /dev/null

cd $HOME/.firefox
tar xvf $HOME/.firefox/firefox.tar.bz2 > /dev/null
mv firefox firefox-tar
mv firefox-tar/* ./ > /dev/null
rm -rf firefox-tar
cd "$WORKING_DIR"

echo "export PATH=\"\$HOME/.firefox:\$PATH\"" >> $TARGET

cat << EOM > $HOME/Desktop/Firefox.desktop
#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Name=Mozilla Firefox
GenericName=Web Browser
Exec=$HOME/.firefox/firefox-bin
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=firefox
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml_xml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
EOM

chmod +x $HOME/Desktop/Firefox.desktop



echo "[DONE] Installed Latest version of Firefox"




echo "[RUN ] Installing Latest version of Visual Studio Code"

# Install VSCode
mkdir $HOME/.code
curl -L "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64" -o $HOME/.code/code.tar.gz 2> /dev/null

cd $HOME/.code
tar xzvf $HOME/.code/code.tar.gz > /dev/null
mv VSCode-linux-x64/* ./
rm -rf VSCode-linux-x64
cd "$WORKING_DIR"

echo "export PATH=\"\$HOME/.code/bin:\$PATH\"" >> $TARGET
echo "alias code=\"code --no-sandbox\"" >> $TARGET

cat << EOM > $HOME/Desktop/VSCode.desktop
#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Name=Visual Studio Code
Comment=Code Editing. Redefined.
GenericName=Text Editor
Exec=$HOME/.code/code --no-sandbox --unity-launch %F
Icon=com.visualstudio.code
Type=Application
StartupNotify=false
StartupWMClass=Code
Categories=Utility;TextEditor;Development;IDE;
MimeType=text/plain;inode/directory;
Actions=new-empty-window;
Keywords=vscode;
EOM

chmod +x $HOME/Desktop/VSCode.desktop

echo "[DONE] Installed Latest version of Visual Studio Code"


source $TARGET
export PATH="$PATH"

# n is installed.
echo "Please run 'source ~/.bashrc' to apply newly configured dev environment"
