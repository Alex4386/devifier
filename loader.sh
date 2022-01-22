#!/bin/bash
mkdir -p $HOME/.devifier
curl https://raw.githubusercontent.com/Alex4386/devifier/main/devifier.sh > $HOME/.devifier/devifier.sh
chmod +x $HOME/.devifier/devifier.sh

bash $HOME/.devifier/devifier.sh
