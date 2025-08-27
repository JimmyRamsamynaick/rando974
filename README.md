# Rando974 🏝️

**Guide touristique interactif de l'île de la Réunion**

Rando974 est une application mobile Flutter complète qui vous accompagne dans la découverte des merveilles de l'île de la Réunion (974). Que vous soyez amateur de randonnées, passionné de photographie ou simplement curieux de découvrir cette île exceptionnelle, cette application est votre compagnon idéal.

## ✨ Fonctionnalités

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
- Guide complet des sentiers de randonnée
- Filtrage par niveau de difficulté
- Conseils de sécurité et équipement
- Informations détaillées sur chaque parcours

### 🌤️ Météo en temps réel
- Prévisions météorologiques pour différentes zones
- Conseils adaptés aux conditions climatiques
- Interface intuitive avec données détaillées

### 📸 Galerie photo
- Collection de photos des paysages réunionnais
- Filtrage par catégories (paysages, faune, culture, etc.)
- Interface en grille responsive
- Détails et informations sur chaque photo

## 🛠️ Technologies utilisées

- **Framework**: Flutter 3.35.2
- **Langage**: Dart 3.9.0
- **State Management**: Provider
- **Navigation**: Go Router
- **Cartes**: Google Maps Flutter
- **HTTP**: Package HTTP pour les requêtes
- **Images**: Cached Network Image
- **Géolocalisation**: Geolocator
- **Stockage local**: Shared Preferences
- **Icônes météo**: Weather Icons
- **Animations**: Lottie

## 📱 Plateformes supportées

- ✅ **iOS** (iPhone & iPad)
- ✅ **Android**
- ✅ **Web** (Chrome, Safari, Firefox)
- ✅ **macOS**
- ✅ **Windows**
- ✅ **Linux**

## 🚀 Installation et lancement

### Prérequis
- Flutter SDK 3.35.2 ou supérieur
- Dart 3.9.0 ou supérieur
- Un éditeur de code (VS Code, Android Studio, etc.)

### Étapes d'installation

1. **Cloner le repository**
   ```bash
   git clone https://github.com/votre-username/rando974.git
   cd rando974
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Lancer l'application**
   ```bash
   # Pour le web
   flutter run -d chrome
   
   # Pour mobile (avec un émulateur/appareil connecté)
   flutter run
   
   # Pour desktop
   flutter run -d macos    # macOS
   flutter run -d windows  # Windows
   flutter run -d linux    # Linux
   ```

## 🏗️ Structure du projet

```
lib/
├── main.dart                 # Point d'entrée de l'application
├── providers/
│   └── app_state.dart       # Gestion d'état globale
└── screens/
    ├── home_screen.dart     # Page d'accueil
    ├── discover_screen.dart # Découverte des lieux
    ├── hiking_screen.dart   # Section randonnées
    ├── weather_screen.dart  # Météo
    └── gallery_screen.dart  # Galerie photo

assets/
├── images/                  # Images et illustrations
├── icons/                   # Icônes personnalisées
└── animations/              # Animations Lottie
```

## 🎨 Design et UX

- **Thème**: Inspiré des couleurs tropicales de la Réunion
- **Couleur principale**: Vert nature (#2E7D32)
- **Navigation**: Bottom tab bar intuitive
- **Responsive**: Adapté à toutes les tailles d'écran
- **Accessibilité**: Respect des standards d'accessibilité

## 🌟 Fonctionnalités à venir

- [ ] Mode hors-ligne
- [ ] Système de favoris
- [ ] Partage sur les réseaux sociaux
- [ ] Notifications push pour la météo
- [ ] Réalité augmentée pour les points d'intérêt
- [ ] Communauté d'utilisateurs
- [ ] Upload de photos par les utilisateurs

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :

1. Fork le projet
2. Créer une branche pour votre fonctionnalité (`git checkout -b feature/AmazingFeature`)
3. Commit vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 📞 Contact

Pour toute question ou suggestion :

- **Email**: contact@rando974.com
- **Issues**: [GitHub Issues](https://github.com/votre-username/rando974/issues)

## 🙏 Remerciements

- Office de Tourisme de la Réunion pour les informations touristiques
- Communauté Flutter pour les packages utilisés
- Photographes locaux pour les magnifiques images

---

**Développé avec ❤️ pour l'île de la Réunion 🇷🇪**
