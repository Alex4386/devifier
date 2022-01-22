#!/bin/bash

rm -rf $HOME/.devifier

mkdir -p $HOME/.devifier
curl https://raw.githubusercontent.com/Alex4386/devifier/main/devifier.sh > $HOME/.devifier/devifier.sh
chmod +x $HOME/.devifier/devifier.sh

$HOME/.devifier/devifier.sh
