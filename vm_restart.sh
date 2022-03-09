#!/bin/bash
#Script pour redémarrer rapidement sa VM

rm -rf logs/*
rm -rf *.log
status=$(vagrant status)
echo "-------------------------------------------"
echo "Le status de vagrant AVANT le lancement est le suivant : "
echo $status
echo "-------------------------------------------"
echo "Vagrant halt..."
vagrant halt --no-tty
echo "Vagrant destroy..."
vagrant destroy --no-tty -f
echo "Vagrant up..."
vagrant up 

echo "-------------------------------------------"
echo "Le status de vagrant APRES le lancement est le suivant : "
status=$(vagrant status)
echo $status
echo "-------------------------------------------"
