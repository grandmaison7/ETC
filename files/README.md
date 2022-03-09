- VM en sous l'OS Debian
- Présence de fonctionnalités de bases : Php / MariaDB (Moodle pour les tests)
- A utiliser pour construire les autres VMs du projet ETC (Gr 2) et respecter sa sémantique/méthode 


-> Lancer dans le répertoire où est enregistré ce fichier la commande : vagrant up
-> 4 éléments majeurs :
    -> Fichiers Files : fichier de la VM. Pour l'exemple, un fichier Php.info 
    -> Fichiers Logs
    -> Fichiers Scripts : On retrouve les différents scripts, il faut bien séparer les scripts en fonction des fonctionnalités (ex: system, moodle)
    -> Vagrant Files 
On retrouve également un script vm_restart.sh pour relancer la VM : la commande : bash vm_restart.sh

-> Respecter la sémantique : 
 -> nom d'un script 
 -> Logs
 -> nom de la VM
