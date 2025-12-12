OSINT Report – holbertonschool.com

Analyse Shodan – Informations collectées

1. Scope et méthodologie

Recherche ciblée via Shodan sur le domaine holbertonschool.com et ses sous-domaines connus.
Objectifs :

Identifier les adresses IP et plages associées.

Recenser les technologies / frameworks visibles sur les services exposés.

Résumer les observations réseau (HTTP headers, SSL, hébergement).

2. Adresses IP observées
2.1 Liste des IP trouvées
Adresse IP	Résolution DNS	Localisation	Fournisseur
35.180.27.154	ec2-35-180-27-154.eu-west-3.compute.amazonaws.com	Paris, France	Amazon Data Services France
52.47.143.83	ec2-52-47-143-83.eu-west-3.compute.amazonaws.com, yriry2.holbertonschool.com	Paris, France	Amazon Data Services France
2.2 Plages d’IP probables

Les deux adresses proviennent de la région AWS eu-west-3 (Paris).
Sans deviner, les plages AWS associées à cette région incluent typiquement :

35.180.0.0/16

52.47.0.0/16

(Remarque : ces plages sont larges, mais Shodan confirme que les hôtes observés proviennent de ces blocs Amazon.)

3. Services et comportements HTTP
3.1 Hôte : 35.180.27.154

Observations Shodan :

HTTP/1.1 301 Moved Permanently

Redirection vers : http://holbertonschool.com

Server : nginx/1.18.0 (Ubuntu)

Contenu minimal (page 301 standard).

En-têtes simples, aucune particularité.

Serviteur catalogué par Shodan : cloudeol-product.

3.2 Hôte : 52.47.143.83 / yriry2.holbertonschool.com

Observations :

Sous-domaine : yriry2.holbertonschool.com

HTTP/1.1 200 OK (via HTTPS après redirection)

Server : nginx

Sécurité HTTP :

X-Frame-Options: SAMEORIGIN

X-XSS-Protection: 0

X-Content-Type-Options: nosniff

X-Download-Options: noopen

Certificat SSL :

Émis par : Let’s Encrypt

Domaine : yriry2.holbertonschool.com

Versions supportées : TLSv1.2, TLSv1.3

Versions vues selon snapshots Shodan :

nginx/1.21.6

redirections HTTP → HTTPS

4. Technologies identifiées
Service	Technologie	Commentaire
HTTP	nginx (Ubuntu / Debian)	Serveur frontal classique, cohérent avec AWS EC2
SSL	Let’s Encrypt	Certificats automatiques pour sous-domaines
Framework applicatif	Non détecté	Le contenu HTTP renvoyé est très limité ; pas d’empreinte (headers, cookies) permettant d’identifier un framework web.
5. Sous-domaines connus via Shodan
Sous-domaine	IP	Statut
yriry2.holbertonschool.com	52.47.143.83	Actif, HTTPS, nginx
holbertonschool.com (redirection depuis 35.180.27.154)	35.180.27.154	Redirection HTTP

À ce stade, Shodan ne révèle pas d’autres sous-domaines exposant des services publics.

6. Synthèse

Les services liés au domaine holbertonschool.com semblent :

Hébergés exclusivement dans AWS eu-west-3 (Paris).

Servis via nginx sur des instances EC2.

Assurés par Let’s Encrypt pour la gestion TLS.

Principalement constitués de redirections HTTP → HTTPS et d’un portail accessible (yriry2).

Aucune technologie applicative interne n’est exposée via Shodan (pas de fingerprint clair d’un CMS, framework JS, backend Ruby/Python/etc.).
