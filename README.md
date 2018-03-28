# Analyse: Das verbaute Land
Das Repository enthält eine Dokumentation unserer Analyse des Flächenverbrauchs in Bayern. Diese liegt in Form eines R-Notebooks vor und macht die Berechnungen transparent und reproduzierbar. 

- **Live**: http://web.br.de/interaktiv/flaechenverbrauch/

## Verwendung
1. Repository klonen `git clone https://...`
2. `analyse.Rmd` in RStudio öffnen
3. Code-Chunks ausführen
4. `analyse.html` enthält eine [HTML-Version]() des gesamten Prozesses

## Datenquellen
Die in die Analyse eingehenden Rohdaten befinden sich im Ordner `input`. Die jeweiligen Quellen sind:

** Fortschreibung des Bevölkerungsstandes** durch das Bayerische Landesamts für Statistik 
** Flächenerhebung nach Art der Tatsächlichen Nutzung:** Die Statistik basiert auf dem Amtlichen Liegenschaftskataster-Informationssystem (ALKIS) der bayerischen Vermessungsämter. Digital ausgemessenen Flächen wird hier eine Nutzungsart zugeordnet, wie Wohnbaufläche, gewerblich genutzte Fläche oder Fläche gemischter Nutzung.
** IHK-Portal:** Anbieter und Kommunen stellen im IHK-Portal potenzielle Gewerbeflächen ein. Das geschieht allerdings auf freiwilliger Basis: Die Auflistung erhebt also keinen Anspruch auf Vollständigkeit. Zu beachten ist außerdem, dass auch Konversionsflächen verzeichnet sind. Das können zum Beispiel ehemalige Flächen der Bundeswehr sein, für die eine gewerbliche Nachnutzung erwünscht ist. 

## Resultate
Im Ordner `output` befinden sich Dateien die im Zug der Analyse entstanden sind. Diese Daten fließen unter Anderem in den Infografiken in die Geschichte ein. 
