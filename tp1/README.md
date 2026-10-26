# TP4 & TP5 Flutter : annonces immobilières

Application Flutter réalisée dans le cadre des travaux pratiques de développement mobile. Elle affiche des annonces de location sous forme de cartes, avec un carrousel d'offres en haut de la page d'accueil et une barre de navigation courbée en bas pour passer d'une page à l'autre.

- **TP4** : Column, Card, ListTile, Container, Align, OverflowBar, TextButton, ListView
- **TP5** : carousel_slider, Expanded

## Captures d'écran

| Accueil (carrousel + liste d'annonces) | Search (démonstration de `Expanded` / `flex`) |
|:---:|:---:|
| <img src="screenshots/sc1.png" width="260"> | <img src="screenshots/sc2.png" width="260"> |

## Fonctionnalités

- **Navigation** entre 4 pages (Home, Search, Chat, Profile) avec une `CurvedNavigationBar`. Le contenu change via un `IndexedStack`, tandis que l'`AppBar` et la barre de navigation restent affichées.
- **Carrousel d'offres** avec défilement automatique, page centrale agrandie et défilement infini.
- **Cartes d'annonces** réutilisables (`ItemHome`) : prix, surface, bouton favori, photo, description et boutons d'action.
- **Page de démonstration de `Expanded`** : deux zones qui se partagent l'écran selon un ratio `flex` de 2:1.

## Widgets étudiés

### TP4

| Widget | Rôle dans l'application |
|---|---|
| `Card` | Conteneur de chaque annonce, avec une ombre (`elevation: 4`) |
| `Column` | Empile les éléments de la carte ; `mainAxisSize: MainAxisSize.min` ajuste la hauteur de la carte à son contenu |
| `ListTile` | En-tête de la carte : `title` (prix), `subtitle` (surface), `trailing` (icône favori) |
| `Container` | Enveloppe l'image et la description ; `padding` ajoute un espace intérieur au texte |
| `Image.asset` | Affiche une photo locale déclarée dans `pubspec.yaml` |
| `Align` | Place la barre de boutons à droite (`AlignmentDirectional.centerEnd`) |
| `OverflowBar` | Aligne les boutons et les passe à la ligne s'il n'y a pas assez de place |
| `TextButton` | Boutons « Vérifier la disponibilité » et « Contactez Nous » |
| `ListView` | Rend la liste des cartes défilable |

### TP5

| Widget | Rôle dans l'application |
|---|---|
| `CarouselSlider` | Affiche les offres en haut de la page d'accueil (`autoPlay`, `enlargeCenterPage`, `viewportFraction`…) |
| `Expanded` | Donne à un enfant de `Column` ou de `Row` tout l'espace restant |
| `flex` | Fixe la proportion de chaque `Expanded` (ici 2 parts pour le vert, 1 pour l'orange) |

**Point important :** une `ListView` placée directement dans une `Column` provoque l'erreur *« Vertical viewport was given unbounded height »*. La solution consiste à l'envelopper dans un `Expanded` pour qu'elle prenne uniquement l'espace restant sous le carrousel.

## Structure du projet

```
lib/
├── main.dart           # MaterialApp, Scaffold, AppBar, CurvedNavigationBar + IndexedStack
├── home_page.dart      # Column : OfferPage + Expanded(ListView d'ItemHome)
├── item_home.dart      # Carte d'une annonce
├── offer_page.dart     # Carrousel des offres (CarouselSlider)
├── search_page.dart    # Démonstration d'Expanded et flex
├── chat_page.dart
└── profile_page.dart
assets/                 # Images des annonces et des offres
screenshots/            # Captures d'écran du README
```

## Dépendances

| Package | Utilisation |
|---|---|
| [`curved_labeled_navigation_bar`](https://pub.dev/packages/curved_labeled_navigation_bar) | Barre de navigation courbée avec libellés |
| [`carousel_slider`](https://pub.dev/packages/carousel_slider) | Carrousel des offres |

## Installation et lancement

Prérequis : avoir installé le [Flutter SDK](https://docs.flutter.dev/get-started/install), et disposer d'un émulateur ou d'un appareil connecté.

```bash
git clone <url-du-repo>
cd <nom-du-repo>
flutter pub get
flutter run
```

> Après l'ajout d'une nouvelle image dans `assets/`, il faut relancer complètement l'application. Le hot reload ne charge pas les nouveaux assets.

## Auteur
 
**Ahmed Nour Zouari**