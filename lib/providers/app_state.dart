import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isLoading = false;
  String _currentLocation = 'Saint-Denis';
  
  // Getters
  int get selectedIndex => _selectedIndex;
  bool get isLoading => _isLoading;
  String get currentLocation => _currentLocation;
  
  // Setters
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
  
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void setCurrentLocation(String location) {
    _currentLocation = location;
    notifyListeners();
  }
  
  // Liste des lieux touristiques de la Réunion
  final List<Map<String, dynamic>> touristicPlaces = [
    {
      'name': 'Piton de la Fournaise',
      'description': 'Volcan actif et site emblématique de la Réunion',
      'image': 'assets/images/piton_fournaise.jpg',
      'latitude': -21.244,
      'longitude': 55.708,
      'category': 'Volcan',
    },
    {
      'name': 'Cirque de Mafate',
      'description': 'Cirque naturel accessible uniquement à pied',
      'image': 'assets/images/mafate.jpg',
      'latitude': -21.1,
      'longitude': 55.45,
      'category': 'Cirque',
    },
    {
      'name': 'Cirque de Salazie',
      'description': 'Le cirque le plus vert avec ses cascades',
      'image': 'assets/images/salazie.jpg',
      'latitude': -21.03,
      'longitude': 55.53,
      'category': 'Cirque',
    },
    {
      'name': 'Cirque de Cilaos',
      'description': 'Station thermale au cœur des montagnes',
      'image': 'assets/images/cilaos.jpg',
      'latitude': -21.13,
      'longitude': 55.47,
      'category': 'Cirque',
    },
    {
      'name': 'Plage de l\'Ermitage',
      'description': 'Plus belle plage de sable blanc de l\'île',
      'image': 'assets/images/ermitage.jpg',
      'latitude': -21.33,
      'longitude': 55.22,
      'category': 'Plage',
    },
    {
      'name': 'Cascade du Voile de la Mariée',
      'description': 'Magnifique cascade dans le cirque de Salazie',
      'image': 'assets/images/voile_mariee.jpg',
      'latitude': -21.03,
      'longitude': 55.53,
      'category': 'Cascade',
    },
  ];
  
  // Liste des randonnées populaires
  final List<Map<String, dynamic>> hikingTrails = [
    {
      'name': 'Piton des Neiges',
      'difficulty': 'Difficile',
      'duration': '6-8h',
      'distance': '12 km',
      'description': 'Point culminant de l\'océan Indien',
      'image': 'assets/images/piton_neiges.jpg',
    },
    {
      'name': 'Trou de Fer',
      'difficulty': 'Modéré',
      'duration': '4-5h',
      'distance': '8 km',
      'description': 'Canyon spectaculaire avec vue sur les cascades',
      'image': 'assets/images/trou_fer.jpg',
    },
    {
      'name': 'Sentier littoral Sud',
      'difficulty': 'Facile',
      'duration': '2-3h',
      'distance': '6 km',
      'description': 'Balade le long des falaises volcaniques',
      'image': 'assets/images/sentier_littoral.jpg',
    },
    {
      'name': 'Forêt de Bélouve',
      'difficulty': 'Modéré',
      'duration': '3-4h',
      'distance': '7 km',
      'description': 'Forêt primaire et point de vue sur le Trou de Fer',
      'image': 'assets/images/belouve.jpg',
    },
  ];
}