# Rando974 🏝️

**Prototype d'application touristique de l'île de la Réunion**

> ⚠️ Cette application est un projet personnel de test. Elle n’est pas encore entièrement fonctionnelle mais constitue une **base solide** pour une future application complète. Développée pour le plaisir et l'apprentissage avec Flutter 🧪

Rando974 est une application mobile Flutter conçue pour accompagner les curieux et amoureux de la nature dans la découverte des merveilles de l'île de la Réunion (974). Que ce soit pour explorer les sentiers de randonnée, admirer les paysages ou consulter la météo, cette application a été pensée comme un compagnon de voyage interactif.

## ✨ Fonctionnalités (prototype)

### 🏠 Page d'accueil
- Présentation immersive de l'île de la Réunion
- Navigation intuitive vers les différentes sections
- Design moderne avec thème tropical

### 🗺️ Découverte des lieux
- Exploration interactive des sites touristiques
- Cartes intégrées avec géolocalisation
- Filtrage par catégories (cirques, volcans, plages, etc.)
- Fiches détaillées pour chaque lieu

### 🥾 Section randonnées
- Guide des sentiers de randonnée
- Filtrage par niveau de difficulté
- Conseils de sécurité et équipement
- Informations sur chaque parcours

### 🌤️ Météo en temps réel
- Prévisions météorologiques par région
- Conseils selon les conditions météo
- Données accessibles via une interface simple

### 📸 Galerie photo
- Collection de photos de paysages réunionnais
- Tri par catégories (paysages, faune, culture, etc.)
- Interface en grille responsive

## 🛠️ Technologies utilisées

- **Framework**: Flutter 3.35.2
- **Langage**: Dart 3.9.0
- **State Management**: Provider
- **Navigation**: Go Router
- **Cartes**: Google Maps Flutter
- **HTTP**: Package HTTP
- **Images**: Cached Network Image
- **Géolocalisation**: Geolocator
- **Stockage local**: Shared Preferences
- **Icônes météo**: Weather Icons
- **Animations**: Lottie

## 📱 Plateformes supportées

- ✅ iOS (iPhone & iPad)
- ✅ Android
- ✅ Web (Chrome, Safari, Firefox)
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 🚀 Installation et lancement

### Prérequis
- Flutter SDK 3.35.2 ou supérieur
- Dart 3.9.0 ou supérieur
- Un éditeur de code (VS Code, Android Studio…)

### Étapes

```bash
# Cloner le projet
git clone https://github.com/votre-username/rando974.git
cd rando974

# Installer les dépendances
flutter pub get

# Lancer l'app
flutter run -d chrome       # Pour le Web
flutter run                 # Pour mobile
flutter run -d macos        # Pour macOS
flutter run -d windows      # Pour Windows
flutter run -d linux        # Pour Linux
```

## 🏗️ Structure du projet

```
lib/
├── main.dart
├── providers/
│   └── app_state.dart
└── screens/
    ├── home_screen.dart
    ├── discover_screen.dart
    ├── hiking_screen.dart
    ├── weather_screen.dart
    └── gallery_screen.dart

assets/
├── images/
├── icons/
└── animations/
```

## 🎨 Design et UX

- **Thème tropical** inspiré de la Réunion
- **Couleur principale**: #2E7D32 (vert nature)
- **Navigation**: Bottom tab bar intuitive
- **Responsive**: Optimisé pour tous les écrans
- **Accessibilité**: Conforme aux bonnes pratiques

## 🌟 Fonctionnalités à venir

- [ ] Mode hors-ligne
- [ ] Système de favoris
- [ ] Partage sur les réseaux sociaux
- [ ] Notifications météo
- [ ] Réalité augmentée
- [ ] Communauté d'utilisateurs
- [ ] Upload de photos

## 🤝 Contribution

Projet perso à but d’apprentissage. Les contributions sont possibles si tu veux t’amuser dessus !

1. Fork
2. Créer une branche (`git checkout -b feature/AmazingFeature`)
3. Commit (`git commit -m 'Add AmazingFeature'`)
4. Push (`git push origin feature/AmazingFeature`)
5. Ouvre une Pull Request

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE`.

## 📞 Contact

Pour toute remarque ou idée :
- **Issues**: [GitHub Issues](https://github.com/JimmyRamsamynaick/rando974/issues)

---

**Développé avec ❤️ pour l'île de la Réunion 🇷🇪 — projet personnel non commercial**
