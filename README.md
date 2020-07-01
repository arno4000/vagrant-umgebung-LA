# vagrant-umgebung-LA
Vagrant-Umgebung für die Lehrlinge der Bedag Informatik AG. Mit hilfe dieser Vagrant-Umgebung ist es einfach möglich, dass du dein eigenes, kleines, virtuelles Rechenzentrum in wenigen Schritten in Betrieb nehmen kannst. Alles was du dazu benötigst, erfährst du in der folgenden Anleitung.

## 1. Voraussetzungen
Um die Vagrant-Umgebung auf deinem Testgerät verwenden zu können, musst du die folgenden Voraussetzungen erfüllen: 
1. Stelle sicher, dass Virtualisierung im BIOS deines Testgerätes aktiviert ist. Falls du dir nicht sicher bist wie du die Virtualisierung aktivieren kannst, versuche im Internet danach zu suchen, oder frage deinen Praxisbildner.
2. Das Programm VirtualBox, welches du [hier](https://www.virtualbox.org/wiki/Downloads "VirtualBox Download") herunterladen kannst.
3. Das Programm Vagrant, welches [hier](https://www.vagrantup.com/downloads "Vagrant Download") heruntergeladen werden kann.
4. Genügend freier Festplattenspeicher. Die Umgebung benötigt um die 40 bis 50 GB.

## 2. Erstmalige Installation
Wenn du alle Voraussetzungen aus Schritt 1 erfüllt hast, kannst du mit der Installation der Umgebung beginnen. Dazu klonst du dieses Repository auf dein Testgerät oder lädst das Zip herunter und entpackst es z.B. auf deinen Desktop oder einen anderen Ort, an dem du es gut finden kannst. Befolge nun folgende Schritte:

1. Starte ein Terminal (CMD oder Powershell) und navigiere mittels dem Befehl `cd` an den Ort, wo du das Repository gespeichert hast. Beispiel: `cd Desktop\vagrant-umgebung-la`
2. Überpüfe mittels dem Befehl `dir` ob du mehrere `.ps1` Scripts und eine Datei namens `Vagrantfile` siehst. Ist dies der Fall, kannst du mit dem nächsten Schritt fortfahren.
3. Starte nun mittels `vagrant up` die Umgebung. Dies kann je nach Internetgeschwindigkeit und Leistung deines Gerätes bis zu 90 Minuten dauern. Du kannst aber gut etwas anderes während dieser Zeit machen. 
4. Wenn du wieder in der Konsole gelandet bist, kannst du dich mittels `vagrant rdp srv01` auf den Domain Controller verbinden. Mit `vagrant rdp srv02` kommst du auf den zweiten Server und mit `vagrant rdp cli01` auf den Client. 

## 3. Die Verschiedenen Maschinen im Überblick
In diesem Abschnitt findest du allerlei nützliche Tipps und Tricks rund um das Thema Vagrant im allgemeinen aber auch in dieser spezifische Umgebung. 
Momentan stehen dir in dieser Umgebung die folgenden drei Maschinen zur Verfügung:

1. `srv01`: Dies ist der Domain Controller, auf dem ein Active Direcory sowie ein DNS-Server läuft. Auf dem Server läuft ein Windows Server 2019 Betriebssystem. Verbinden kannst du dich mit `vagrant rdp srv01`. Die Verbindung via Powershell funktioniert hier leider nicht. 
2. `srv02`: Dies ist ein zweiter Windows Server 2019, auf dem ein IIS-Webserver läuft. Die Webseite davon kannst du erreichen, in dem du im Browser des Clients `http://srv02.vagrant.lab` eingibst. Um dich auf diesen Server zu verbinden kannst du entweder `vagrant rdp srv02` oder `vagrant powershell srv02` verwenden, je nach dem ob du ein GUI möchtest oder nicht.
3. `cli01`: Dies ist der Client, welcher auf Windows 10 Build 2004 basiert. Auf dem Client sind ein paar Programme wie Firefox oder Notepad++ vorinstalliert. Auch hier kannst du dich via `vagrant rdp cli01` oder `vagrant powershell cli01` verbinden. 

## 4. Vagrant-Cheatsheet
In diesem Abschnitt findest du allerlei nützliche Tipps und Tricks rund um diese Umgebung, aber auch rund um Vagrant im allgemeinen.

Die Vagrant-Syntax ist wie folgt aufgebaut: Zuerst kommt immer das Programm `vagrant` selber. Danach sagtst du was du machen willst, also z.B. `vagrant up` um alle Maschinen zu starten. Wenn du jetzt hinter einen Befehl aber noch den Maschinennamen angibst, also z.B. `vagrant up srv02`, so wird der Befehl nur für diese Maschine ausgeführt. Es gibt aber auch Befehle, wie `vagrant powershell` oder `vagrant rdp`, wo du den Maschinennamen angeben musst.

Wenn du nur `vagrant` eingibst, so siehst du eine Übersicht mit allen verfügbaren Befehlen. Mit `vagrant up --help` z.B. kannst du dir auch Hilfe zu einem bestimmten Befehl ausgeben lassen. 

- `vagrant halt`: Alle Maschinen herunterfahren
- `vagrant up`: Die Maschinen erneut starten
- `vagrant halt cli01`: Nur cli01 herunterfahren
- `vagrant reload`: Alle Maschinen neu starten
- `vagrant destroy srv01`: srv01 löschen, kann mit `vagrant up srv01` erneut erstellt und gestartet werden. 
- `vagrant provision`: Die Installationsscripts noch einmal ausführen.
- Weitere nützliche Tipps und Tricks findest du in der offiziellen Dokumentation von [Vagrant](https://www.vagrantup.com/docs/cli) (auf Englisch).
