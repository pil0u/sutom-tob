### stuom-tob

Un solveur pour le jeu [SUTOM](https://sutom.nocle.fr/), une [adaptation libre]((https://framagit.org/JonathanMM/sutom/)) du jeu Motus.

En cours de développement [sur Twitch](https://www.twitch.tv/ze_n0ob) et [Discord](https://discord.gg/wSdRCnpEuq).  
Pour s'entraîner au Motus, j'ai mis en ligne la version "joueur humain" du code. [Plus d'infos](#sentrainer-au-motus-en-ligne)

- [Introduction](#introduction)
- [Usage](#usage)
- [Mots du jour](#mots-du-jour)
  - [_Deus ex machina_?](#deus-ex-machina)
- [Benchmark](#benchmark)
  - [Tentatives moyennes](#tentatives-moyennes)
  - [Statistiques complémentaires](#statistiques-complémentaires)
- [Prochaines étapes](#prochaines-étapes)
- [S'entrainer au Motus en ligne](#sentrainer-au-motus-en-ligne)
  - [Choisir son propre mot](#choisir-son-propre-mot)


## Introduction

L'objectif initial du projet était de créer un algorithme permettant de résoudre le mot du jour directement sur [SUTOM](https://sutom.nocle.fr/) avec du JavaScript.

Après avoir réussi à simuler un parcours dans le navigateur grâce à Puppeteer, j'ai décidé de mettre de côté le JavaScript pour me recentrer sur la partie algorithmique.

Il a fallu recréer le jeu pour que notre solveur puisse y "jouer", pour cela j'ai choisi Ruby :gem:.


## Usage

À la racine du projet, lancer le script avec :
``` zsh
ruby ruby/run.rb
```

Toute la configuration se fait au niveau du fichier `ruby/config.rb`


## Mots du jour

Historique de mes propres parties sur SUTOM. Certains jours ont été réalisés en intelligence collective [sur Twitch](https://www.twitch.tv/ze_n0ob).

Les scores sont en **gras\*** avec astérisque si le solveur a battu l'humain (voir le [score final](#deus-ex-machina))

| Jour | Vainqueur | Mot | Performance humaine | v1 | v2 | v3 | v4 |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 093 | 🕊️ | <span title="SENATRICE">*caché*</span> | 🟥🟦🟦🟡🟡🟡🟡🟡🟦<br>🟥🟡🟥🟦🟥🟦🟥🟡🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥🟥 | 8 | 3 | 3 | 3 |
| 092 | 🕊️ | <span title="ANTIVOL">*caché*</span> | 🟥🟦🟦🟡🟦🟡🟦<br>🟥🟡🟡🟦🟡🟦🟦<br>🟥🟥🟥🟥🟥🟥🟥 | 3 | 4 | 3 | 4 |
| 091 | ❓ | *À résoudre* | **À résoudre** | 9 | 3 | 3 | 3 |
| 090 | ❓ | *À résoudre* | **À résoudre** | 11 | 4 | 2 | 3 |
| 089 | 🤖 | <span title="MULTIVERS">*caché*</span> | 🟥🟦🟦🟦🟥🟦🟥🟥🟦<br>🟥🟦🟦🟡🟡🟦🟡🟡🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥🟥 | 5 | 4 | 3 | **2\*** |
| 088 | 💪 | <span title="BIGOUDI">*caché*</span> | 🟥🟥🟦🟥🟦🟡🟦<br>🟥🟥🟥🟥🟥🟥🟥 | 3 | 3 | 3 | 3 |
| 087 | 💪 | <span title="FAVORITE">*caché*</span> | 🟥🟡🟦🟡🟡🟥🟦🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 4 | 3 | 3 | 3 |
| 086 | 🤖 | <span title="EXPERT">*caché*</span> | 🟥🟦🟡🟦🟦🟡<br>🟥🟡🟡🟦🟦🟦<br>🟥🟡🟦🟡🟡🟡<br>🟥🟥🟥🟥🟥🟥 | 6 | 4 | **3\*** | **3\*** |
| 085 | 🕊️ | <span title="SOMNOLER">*caché*</span> | 🟥🟥🟦🟦🟦🟦🟦🟡<br>🟥🟥🟡🟦🟡🟦🟥🟦<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 6 | 3 | 3 | 3 |
| 084 | 💪 | <span title="CABARET">*caché*</span> | 🟥🟥🟦🟦🟡🟡🟡<br>🟥🟥🟥🟥🟥🟥🟥 | 3 | 3 | 3 | 3 |
| 083 | 💪 | <span title="MIOCHE">*caché*</span> | 🟥🟡🟦🟥🟥🟥<br>🟥🟥🟥🟥🟥🟥 | 8 | 3 | 4 | 4 |
| 082 | 🕊️ | <span title="PARFAIT">*caché*</span> | 🟥🟡🟦🟦🟦🟦🟦<br>🟥🟥🟥🟡🟡🟡🟦<br>🟥🟥🟥🟥🟥🟥🟥 | 6 | 4 | 3 | 4 |
| 081 | ❓ | *À résoudre* | **À résoudre** | 5 | 3 | 3 | 3 |
| 080 | 🕊️ | <span title="GORGEE">*caché*</span> | 🟥🟥🟦🟦🟦🟥<br>🟥🟥🟥🟥🟥🟥 | 3 | 3 | 4 | 2 |
| 079 | 💪 | <span title="ACTRICE">*caché*</span> | 🟥🟡🟡🟦🟦🟡🟡<br>🟥🟥🟥🟡🟦🟡🟡<br>🟥🟥🟥🟥🟥🟥🟥 | 4 | 4 | 4 | 4 |
| 078 | 🕊️ | <span title="FAMEUX">*caché*</span> | 🟥🟦🟦🟡🟦🟡<br>🟥🟥🟦🟥🟥🟦<br>🟥🟥🟥🟥🟥🟥 | 5 | 4 | 4 | 3 |
| 077 | 🕊️ | <span title="SUSPENSE">*caché*</span> | 🟥🟦🟡🟦🟦🟦🟡🟦<br>🟥🟦🟦🟡🟥🟥🟦🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 6 | 4 | 4 | 3 |
| 076 | 🕊️ | <span title="TRAVERS">*caché*</span> | 🟥🟦🟦🟦🟦🟡🟥<br>🟥🟡🟦🟡🟦🟦🟥<br>🟥🟥🟥🟦🟥🟥🟥<br>🟥🟥🟥🟥🟥🟥🟥 | 14 | 5 | 4 | 6 |
| 075 | 🤖 | <span title="COURSIER">*caché*</span> | 🟥🟥🟥🟦🟦🟦🟦🟡<br>🟥🟥🟥🟡🟦🟦🟦🟦<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 5 | 3 | 4 | **2\*** |
| 074 | 💪 | <span title="PENALTY">*caché*</span> | 🟥🟦🟥🟥🟦🟦🟡<br>🟥🟥🟥🟥🟥🟥🟥 | 9 | 3 | 3 | 4 |
| 073 | 🤖 | <span title="DIRECT">*caché*</span> | 🟥🟦🟦🟡🟡🟦<br>🟥🟡🟡🟡🟦🟦<br>🟥🟥🟥🟥🟥🟥 | 6 | **2\*** | 3 | 4 |
| 072 | 🕊️ | <span title="ARNAQUE">*caché*</span> | 🟥🟡🟡🟦🟦🟦🟦<br>🟥🟡🟦🟦🟡🟡🟦<br>🟥🟥🟥🟥🟥🟥🟥 | 6 | 4 | 4 | 3 |
| 071 | 💪 | <span title="RIGOLOTE">*caché*</span> | 🟥🟡🟦🟦🟡🟡🟦🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 9 | 4 | 4 | 3 |
| 070 | 🕊️ | <span title="LONGTEMPS">*caché*</span> | 🟥🟥🟦🟡🟡🟦🟦🟦🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥🟥 | 4 | 3 | 4 | 2 |
| 069 | 🤖 | <span title="MUSEUM">*caché*</span> | 🟥🟦🟡🟦🟦🟦<br>🟥🟡🟦🟡🟡🟦<br>🟥🟥🟦🟥🟦🟡<br>🟥🟥🟥🟥🟦🟡<br>🟥🟥🟥🟥🟥🟥 | **4\*** | **4\*** | **4\*** | **4\*** |
| 068 | ❓ | *À résoudre* | **À résoudre** | 5 | 4 | 3 | 3 |
| 067 | ❓ | *À résoudre* | **À résoudre** | 7 | 5 | 2 | 2 |
| 066 | 🕊️ | <span title="DEGOUTE">*caché*</span> | 🟥🟦🟦🟡🟡🟦🟦<br>🟥🟡🟡🟦🟦🟡🟦<br>🟥🟥🟥🟥🟥🟥🟥 | 5 | 3 | 3 | 3 |
| 065 | 🤖 | <span title="BICLOU">*caché*</span> | 🟥🟦🟡🟦🟦🟦<br>🟥🟡🟡🟦🟡🟦<br>🟥🟥🟦🟡🟡🟦<br>🟥🟥🟥🟥🟥🟥 | 3 | **2\*** | 3 | 3 |
| 064 | 🕊️ | <span title="LABORIEUX">*caché*</span> | 🟥🟡🟦🟥🟦🟡🟡🟡🟦<br>🟥🟥🟥🟥🟥🟥🟥🟥🟥 | 2 | 2 | 3 | 2 |
| 063 | 🤖 | <span title="AFFILEE">*caché*</span> | 🟥🟦🟦🟥🟦🟦🟥<br>🟥🟦🟦🟥🟦🟥🟥<br>🟥🟥🟥🟥🟦🟥🟥<br>🟥🟥🟥🟥🟥🟥🟥 | 5 | 4 | 4 | **3\*** |
| 062 | 🤖 | <span title="GIRAFE">*caché*</span> | 🟥🟦🟦🟦🟡🟡<br>🟥🟡🟡🟦🟥🟥<br>🟥🟥🟥🟥🟥🟥 | 4 | **2\*** | 4 | **2\*** |
| 061 | 🤖 | <span title="COHABITER">*caché*</span> | 🟥🟦🟡🟡🟡🟦🟦🟡🟡<br>🟥🟥🟦🟥🟡🟥🟦🟦🟡<br>🟥🟥🟥🟥🟥🟥🟥🟥🟥 | 5 | **2\*** | 3 | 3 |
| 060 | 🤖 | <span title="EUREKA">*caché*</span> | 🟥🟦🟦🟦🟦🟡<br>🟥🟦🟦🟥🟦🟦<br>🟥🟦🟥🟥🟡🟦<br>🟥🟥🟥🟥🟥🟥 | 8 | 5 | 4 | **3\*** |
| 059 | 🕊️ | <span title="BANALITE">*caché*</span> | 🟥🟦🟦🟦🟡🟦🟡🟡<br>🟥🟥🟡🟡🟦🟡🟡🟦<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 7 | 3 | 3 | 3 |
| 058 | 🕊️ | <span title="SOIGNANTE">*caché*</span> | 🟥🟥🟦🟦🟡🟥🟥🟥🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥🟥 | 3 | 3 | 4 | 2 |
| 057 | 💪 | <span title="PILULE">*caché*</span> | 🟥🟦🟡🟡🟡🟥<br>🟥🟥🟥🟥🟥🟥 | 6 | 3 | 3 | 3 |
| 056 | 🕊️ | <span title="MINUSCULE">*caché*</span> | 🟥🟦🟦🟦🟡🟦🟦🟦🟥<br>🟥🟦🟦🟦🟡🟦🟦🟥🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥🟥 | 4 | 3 | 3 | 3 |
| 055 | 🕊️ | <span title="TUNNEL">*caché*</span> | 🟥🟦🟡🟦🟦🟡<br>🟥🟦🟦🟡🟥🟦<br>🟥🟥🟥🟥🟥🟥 | 9 | 3 | 3 | 4 |
| 054 | 🕊️ | <span title="CYLINDRE">*caché*</span> | 🟥🟦🟡🟦🟡🟦🟡🟦<br>🟥🟦🟡🟡🟦🟦🟥🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 6 | 3 | 3 | 3 |
| 053 | 🤖 | <span title="ADVERBE">*caché*</span> | 🟥🟦🟦🟦🟡🟦🟦<br>🟥🟡🟡🟦🟦🟡🟦<br>🟥🟦🟦🟥🟥🟦🟥<br>🟥🟦🟦🟥🟥🟦🟥<br>🟥🟥🟥🟥🟥🟥🟥 | 5 | **3\*** | **3\*** | 4 |
| 052 | 🕊️ | <span title="LEGUME">*caché*</span> | 🟥🟡🟦🟦🟦🟥<br>🟥🟦🟦🟡🟡🟥<br>🟥🟥🟥🟥🟥🟥 | 6 | 4 | 3 | 3 |
| 051 | 💪 | <span title="BRILLANT">*caché*</span> | 🟥🟡🟡🟦🟦🟦🟥🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 6 | 5 | 4 | 3 |
| 050 | 🕊️ | <span title="GENCIVE">*caché*</span> | 🟥🟦🟦🟦🟦🟡🟦<br>🟥🟥🟥🟡🟦🟦🟦<br>🟥🟥🟥🟥🟥🟥🟥 | 6 | 3 | 3 | 4 |
| 049 | 🤖 | <span title="EXAMEN">*caché*</span> | 🟥🟡🟦🟦🟦🟦<br>🟥🟡🟦🟡🟡🟡<br>🟥🟡🟥🟡🟥🟦<br>🟥🟥🟥🟥🟥🟥 | 9 | 5 | 5 | **3\*** |
| 048 | 🤖 | <span title="MYSTERE">*caché*</span> | 🟥🟦🟦🟦🟡🟡🟡<br>🟥🟦🟡🟥🟥🟦🟡<br>🟥🟥🟥🟥🟥🟥🟥 | 4 | 3 | **2\*** | **2\*** |
| 047 | 💪 | <span title="FRANGLAIS">*caché*</span> | 🟥🟦🟦🟡🟦🟦🟦🟥🟦<br>🟥🟥🟥🟥🟥🟥🟥🟥🟥 | 6 | 3 | 3 | 3 |
| 046 | 💪 | <span title="SACOCHE">*caché*</span> | 🟥🟡🟦🟦🟦🟡🟦<br>🟥🟥🟥🟥🟥🟥🟥 | 6 | 4 | 4 | 3 |
| 045 | 🕊️ | <span title="ADULTE">*caché*</span> | 🟥🟦🟦🟡🟥🟦<br>🟥🟦🟥🟦🟥🟥<br>🟥🟥🟥🟥🟥🟥 | 4 | 3 | 4 | 4 |
| 044 | 🕊️ | <span title="TABOURET">*caché*</span> | 🟥🟡🟦🟥🟦🟡🟡🟦<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 3 | 3 | 3 | 2 |
| 043 | 🤖 | <span title="CLICHE">*caché*</span> | 🟥🟦🟦🟦🟡🟦<br>🟥🟦🟡🟦🟡🟦<br>🟥🟥🟥🟦🟦🟥<br>🟥🟥🟥🟥🟥🟥 | 6 | 4 | **3\*** | **3\*** |
| 042 | 🕊️ | <span title="MITONNER">*caché*</span> | 🟥🟥🟡🟡🟡🟦🟦🟦<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 7 | 4 | 2 | 3 |
| 041 | 🤖 | <span title="DOPAGE">*caché*</span> | 🟥🟦🟦🟦🟡🟦<br>🟥🟡🟦🟥🟦🟦<br>🟥🟥🟦🟥🟦🟥<br>🟥🟥🟥🟥🟥🟥 | 7 | **3\*** | **3\*** | 4 |
| 040 | 🕊️ | <span title="REPTILE">*caché*</span> | 🟥🟦🟦🟡🟦🟡🟦<br>🟥🟡🟥🟦🟦🟡🟥<br>🟥🟥🟥🟥🟥🟥🟥 | 6 | 5 | 3 | 3 |
| 039 | 🕊️ | <span title="FAUBOURG">*caché*</span> | 🟥🟦🟦🟡🟦🟦🟦🟦<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 4 | 3 | 3 | 2 |
| 038 | 🕊️ | <span title="ENORME">*caché*</span> | 🟥🟦🟦🟦🟦🟥<br>🟥🟦🟦🟦🟥🟥<br>🟥🟥🟥🟥🟥🟥 | 5 | 4 | 4 | 3 |
| 037 | 💪 | <span title="COGITER">*caché*</span> | 🟥🟥🟦🟦🟡🟦🟡<br>🟥🟥🟥🟥🟥🟥🟥 | 5 | 4 | 3 | 3 |
| 036 | 🤖 | <span title="FACILE">*caché*</span> | 🟥🟦🟡🟦🟡🟦<br>🟥🟥🟦🟦🟡🟦<br>🟥🟥🟥🟥🟥🟥 | 4 | **2\*** | 3 | **2\*** |
| 035 | 🕊️ | <span title="PREFET">*caché*</span> | 🟥🟦🟥🟦🟦🟡<br>🟥🟥🟥🟡🟥🟦<br>🟥🟥🟥🟥🟥🟥 | 7 | 5 | 3 | 4 |
| 034 | 🤖 | <span title="TAMBOUR">*caché*</span> | 🟥🟡🟦🟦🟦🟦🟦<br>🟥🟡🟡🟦🟦🟡🟡<br>🟥🟥🟥🟥🟥🟥🟥 | 4 | **2\*** | 3 | 3 |
| 033 | 🕊️ | <span title="MENTAL">*caché*</span> | 🟥🟡🟦🟦🟡🟦<br>🟥🟥🟡🟡🟡🟡<br>🟥🟥🟥🟥🟥🟥 | 4 | 3 | 4 | 3 |
| 032 | 🕊️ | <span title="RELIEF">*caché*</span> | 🟥🟡🟦🟦🟥🟡<br>🟥🟥🟥🟥🟥🟦<br>🟥🟥🟥🟥🟥🟥 | 10 | 3 | 4 | 4 |
| 031 | 🤖 | <span title="PARAPLUIE">*caché*</span> | 🟥🟡🟦🟡🟡🟥🟦🟦🟥<br>🟥🟡🟦🟦🟡🟥🟦🟦🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥🟥 | 4 | **2\*** | 3 | **2\*** |
| 030 | 💪 | <span title="SAPRISTI">*caché*</span> | 🟥🟥🟦🟦🟡🟦🟦🟦<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 5 | 3 | 4 | 3 |
| 029 | 🤖 | <span title="PREJUGE">*caché*</span> | 🟥🟦🟦🟡🟡🟦🟥<br>🟥🟦🟡🟡🟦🟦🟥<br>🟥🟥🟥🟦🟥🟦🟥<br>🟥🟥🟥🟥🟥🟥🟥 | 5 | **3\*** | **3\*** | 4 |
| 028<br>(*Twitch*) | 🕊️ | <span title="GADGET">*caché*</span> | 🟥🟥🟦🟦🟦🟦<br>🟥🟥🟡🟡🟦🟦<br>🟥🟥🟥🟥🟥🟥 | 3 | 3 | 4 | 3 |
| 027 | 💪 | <span title="TOUBIB">*caché*</span> | 🟥🟦🟥🟦🟥🟦<br>🟥🟥🟥🟥🟥🟥 | 4 | 3 | 3 | 3 |
| 026 | 🕊️ | <span title="BOURRIN">*caché*</span> | 🟥🟦🟡🟡🟦🟦🟦<br>🟥🟦🟡🟡🟦🟦🟡<br>🟥🟥🟥🟥🟥🟥🟥 | 8 | 4 | 3 | 3 |
| 025 | 🤖 | <span title="RACLETTE">*caché*</span> | 🟥🟦🟦🟦🟡🟡🟦🟥<br>🟥🟡🟦🟡🟦🟡🟦🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 5 | 4 | 3 | **2\*** |
| 024 | 🕊️ | <span title="FATIGUE">*caché*</span> | 🟥🟥🟦🟥🟦🟡🟦<br>🟥🟥🟥🟥🟥🟥🟥 | 7 | 4 | 3 | 2 |
| 023 | 🕊️ | <span title="GRENIER">*caché*</span> | 🟥🟦🟡🟦🟡🟦🟦<br>🟥🟥🟡🟦🟦🟦🟡<br>🟥🟥🟥🟥🟥🟥🟥 | 3 | 3 | 3 | 3 |
| 022 | 🤖 | <span title="AIRBAG">*caché*</span> | 🟥🟦🟦🟦🟦🟦<br>🟥🟡🟥🟦🟦🟡<br>🟥🟥🟥🟥🟥🟥 | 9 | **2\*** | 3 | 3 |
| 021 | 🤖 | <span title="SUPPLICE">*caché*</span> | 🟥🟦🟥🟦🟡🟦🟦🟦<br>🟥🟥🟥🟥🟦🟦🟡🟦<br>🟥🟥🟥🟥🟥🟥🟦🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 6 | **3\*** | **3\*** | **3\*** |
| 020 | ❓ | *À résoudre* | **À résoudre** | 4 | 3 | 3 | 4 |
| 019 | ❓ | *À résoudre* | **À résoudre** | 5 | 4 | 3 | 3 |
| 018<br>(*Twitch*) | 💪 | <span title="REMPART">*caché*</span> | 🟥🟡🟦🟦🟦🟡🟡<br>🟥🟥🟥🟥🟥🟥🟥 | 11 | 4 | 3 | 4 |
| 017<br>(*Twitch*) | 💪 | <span title="LUCIOLE">*caché*</span> | 🟥🟦🟦🟦🟦🟦🟥<br>🟥🟥🟥🟥🟥🟥🟥 | 6 | 4 | 4 | 3 |
| 016<br>(*Twitch*) | 🕊️ | <span title="PETUNIA">*caché*</span> | 🟥🟥🟡🟡🟦🟦🟦<br>🟥🟥🟦🟡🟦🟡🟡<br>🟥🟥🟥🟥🟥🟥🟥 | 5 | 3 | 3 | 3 |
| 015<br>(*Twitch*) | 💪 | <span title="COLLIER">*caché*</span> | 🟥🟥🟦🟦🟥🟦🟡<br>🟥🟥🟥🟥🟥🟥🟥 | 7 | 3 | 5 | 3 |
| 014<br>(*Twitch*) | 🕊️ | <span title="DIFFUSER">*caché*</span> | 🟥🟦🟦🟡🟡🟡🟡🟦<br>🟥🟦🟦🟡🟡🟦🟥🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 9 | 3 | 3 | 3 |
| 013<br>(*Twitch*) | 🕊️ | <span title="ROUGEAUD">*caché*</span> | 🟥🟡🟦🟦🟡🟡🟥🟦<br>🟥🟥🟥🟦🟥🟥🟥🟦<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 7 | 3 | 3 | 3 |
| 012<br>(*Twitch*) | 💪 | <span title="APPOINT">*caché*</span> | 🟥🟦🟡🟡🟡🟦🟦<br>🟥🟥🟥🟥🟥🟥🟥 | 4 | 4 | 4 | 4 |
| 011<br>(*Twitch*) | 💪 | <span title="CAHIER">*caché*</span> | 🟥🟡🟡🟥🟦🟡<br>🟥🟥🟥🟥🟥🟥 | 9 | 3 | 5 | 3 |
| 010<br>(*Twitch*) | 🤖 | <span title="RINGARDE">*caché*</span> | 🟥🟦🟦🟦🟡🟥🟡🟡<br>🟥🟡🟦🟦🟡🟡🟦🟦<br>🟥🟡🟦🟦🟦🟥🟡🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 8 | 4 | 4 | **2\*** |
| 009<br>(*Twitch*) | 🕊️ | <span title="HABITUE">*caché*</span> | 🟥🟥🟥🟥🟥🟡🟦<br>🟥🟥🟥🟥🟥🟥🟥 | 5 | 2 | 2 | 2 |
| 008 | 💪 | <span title="ENVAHIR">*caché*</span> | 🟥🟦🟦🟡🟡🟡🟦<br>🟥🟡🟡🟦🟡🟦🟡<br>🟥🟥🟥🟥🟥🟥🟥 | 4 | 4 | 5 | 4 |
| 007<br>(*Twitch*) | 🕊️ | <span title="BAGAGES">*caché*</span> | 🟥🟦🟦🟦🟡🟦🟡<br>🟥🟥🟦🟡🟦🟦🟦<br>🟥🟥🟥🟥🟥🟥🟥 | 3 | 3 | 4 | 4 |
| 006<br>(*Twitch*) | 🕊️ | <span title="TANDEM">*caché*</span> | 🟥🟦🟦🟦🟦🟡<br>🟥🟥🟦🟡🟡🟦<br>🟥🟥🟥🟦🟥🟦<br>🟥🟥🟥🟥🟥🟥 | 8 | 4 | 4 | 4 |
| 005<br>(*Twitch*) | 🤖 | <span title="TRICHERIE">*caché*</span> | 🟥🟦🟦🟡🟡🟦🟦🟡🟦<br>🟥🟡🟦🟦🟦🟦🟡🟡🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥🟥 | 4 | 3 | **2\*** | 3 |
| 004<br>(*Twitch*) | 🤖 | <span title="VALSEURS">*caché*</span> | 🟥🟥🟡🟦🟥🟦🟦🟥<br>🟥🟥🟦🟡🟥🟡🟦🟥<br>🟥🟥🟦🟦🟥🟥🟥🟥<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 5 | 3 | 3 | **2\*** |
| 003<br>(*Twitch*) | 🕊️ | <span title="GLOBALES">*caché*</span> | 🟥🟡🟦🟦🟦🟡🟦🟦<br>🟥🟡🟡🟡🟡🟦🟡🟡<br>🟥🟥🟥🟥🟥🟥🟥🟥 | 7 | 3 | 4 | 5 |
| 002<br>(*Twitch*) | 🤖 | <span title="PELTAS">*caché*</span> | 🟥🟦🟡🟡🟦🟦<br>🟥🟦🟦🟥🟥🟥<br>🟥🟥🟦🟥🟥🟥<br>🟥🟥🟥🟥🟥🟥 | 11 | 4 | **2\*** | **2\*** |
| 001<br>(*Twitch*) | 🕊️ | <span title="AVORTAI">*caché*</span> | 🟥🟦🟡🟦🟡🟦🟦<br>🟥🟦🟦🟡🟡🟡🟦<br>🟥🟥🟥🟥🟥🟦🟦 | 8 | 4 | 3 | 3 |

### _Deus ex machina_?

| 💪 | 🤖 | 🕊️ | ❓ |
| :---: | :---: | :---: | :---: |
| 20 | 26 | 40 | 7 |


## Benchmark

### Tentatives moyennes

| Échantillon | v1 | v2 | v3 |
| :---------- | :---: | :---: | :---: |
| 100 mots    |  |  |  |
| 1k mots     |  |  |  |
| 5k mots     |  |  |  |
| 10k mots    |  |  |  |
| 150k mots   |  |  |  |

### Statistiques complémentaires

**v1**

| Échantillon | min | 25% | 50% | 75% | max | µ | σ | 90% | 95% | 99% |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 100 mots |
| 1k mots |
| 5k mots |
| 10k mots |
| 150k mots |


## Prochaines étapes

- [x] Modifier le `run` des bots (et du player) pour charger la matrice au début : plus besoin de calculer !
- [ ] Créer une version qui utilise les calculs d'entropie
- [ ] Benchmarker _efficacement_ (mémoïsation ?) les différentes versions du solveur et archiver les résultats
- [ ] Compléter la partie Usage du README
- [ ] Stocker les résultats des benchmarks dans des fichiers (YAML, JSON...) ([exemple](https://stackoverflow.com/questions/30718214/saving-hashes-to-file-on-ruby))
- [ ] Ajouter les versions (Ruby, Node) utilisées
- [ ] Créer une extension de navigateur qui résout le mot SUTOM du jour avec notre meilleure version

<span hidden>(idée) Stream automatique de Motus - intelligence collective vs robot</span>


## S'entrainer au Motus en ligne

Pour créer un solveur, il faut que l'algorithme puisse jouer au jeu. Par conséquent, j'ai dû reproduire le jeu et ses règles en Ruby. J'en ai profité pour mettre cette version jouable en ligne.

Pour lancer une partie avec un mot aléatoire :
1. Se rendre sur [cette page](https://replit.com/@pierreloicp/SUTOM?v=1)
2. Cliquer une fois sur le bouton vert `Run`
3. Patienter jusqu'à ce que le `Mot à trouver` s'affiche.
4. La partie peut démarrer.

À noter :
- Le mot est choisi aléatoirement parmi les 150 000 mots du dictionnaire (le fichier `mots.txt`). Cela inclut des verbes conjugués et autres mots peu usités.
- Le nombre de tentatives est illimité.
- Écrire en minuscule fonctionne très bien.
- En cas de blocage sur un mot, vous pouvez taper `q` ou `Q` en guise de proposition et le jeu s'arrête **en vous dévoilant la solution**.

### Choisir son propre mot

Si vous souhaitez prendre la main sur le mot à faire deviner pour le partager à vos amis ou faire jouer des élèves, voici les étapes à suivre :
1. Créez un compte sur [Replit](https://replit.com/)
2. Sur la [page de mon script](https://replit.com/@pierreloicp/SUTOM?v=1), cliquez sur le bouton `Fork repl`. Cette action sauvegarde le script (le code) dans votre propre espace Replit et vous permet de le modifier, l'adapter à vos besoins.
3. Parmi les fichiers à gauche, cliquez sur `main.rb` et remplacer entièrement la ligne 8 avec, par exemple :
``` ruby
mot = "JUSTICE"
```
**Le mot doit être entre guillemet et en majuscules**. Vous pouvez jeter un œil rapide au fichier `mots.txt` pour vérifier que votre mot existe bien dans le dictionnaire.

4. (Optionnel) Quand le mot est choisi, n'hésitez pas à tester en cliquant sur `Run` et en jouant votre partie.
5. En haut à gauche, à côté du nom du projet, cliquez sur le petit rubis, puis sur `⋮` (à droite dans le menu ouvert) et enfin sur `Spotlight`. Cette action vous redirige vers la page que vous pouvez partager à vos amis pour qu'ils jouent.

Si vous souhaitez modifier le mot, il suffit de recommencer à partir de l'étape 3. L'URL reste la même pour vos amis !
