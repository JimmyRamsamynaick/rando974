import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _selectedLocation = 'Saint-Denis';
  bool _isLoading = false;
  Map<String, dynamic>? _weatherData;
  
  final List<Map<String, dynamic>> _locations = [
    {'name': 'Saint-Denis', 'lat': -20.8823, 'lon': 55.4504},
    {'name': 'Saint-Pierre', 'lat': -21.3393, 'lon': 55.4781},
    {'name': 'Saint-Paul', 'lat': -21.0099, 'lon': 55.2697},
    {'name': 'Le Port', 'lat': -20.9376, 'lon': 55.2919},
    {'name': 'Cilaos', 'lat': -21.1367, 'lon': 55.4721},
    {'name': 'Plaine des Palmistes', 'lat': -21.1333, 'lon': 55.6333},
  ];

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Météo Réunion'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadWeatherData,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildLocationSelector(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _weatherData != null
                    ? _buildWeatherContent()
                    : _buildErrorState(),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSelector() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _locations.length,
        itemBuilder: (context, index) {
          final location = _locations[index];
          final isSelected = location['name'] == _selectedLocation;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(location['name']),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedLocation = location['name'];
                  });
                  _loadWeatherData();
                }
              },
              backgroundColor: Colors.grey[200],
              selectedColor: const Color(0xFF2E7D32),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWeatherContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCurrentWeather(),
          const SizedBox(height: 24),
          _buildWeatherDetails(),
          const SizedBox(height: 24),
          _buildHourlyForecast(),
          const SizedBox(height: 24),
          _buildWeatherTips(),
        ],
      ),
    );
  }

  Widget _buildCurrentWeather() {
    final temp = _weatherData!['temperature'] ?? 25;
    final description = _weatherData!['description'] ?? 'Ensoleillé';
    final humidity = _weatherData!['humidity'] ?? 70;
    final windSpeed = _weatherData!['windSpeed'] ?? 15;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2E7D32),
              Color(0xFF4CAF50),
              Color(0xFF81C784),
            ],
          ),
        ),
        child: Column(
          children: [
            Text(
              _selectedLocation,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getWeatherIcon(description),
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${temp.round()}°C',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherStat(
                  Icons.water_drop,
                  'Humidité',
                  '${humidity.round()}%',
                ),
                _buildWeatherStat(
                  Icons.air,
                  'Vent',
                  '${windSpeed.round()} km/h',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherStat(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherDetails() {
    final pressure = _weatherData!['pressure'] ?? 1013;
    final visibility = _weatherData!['visibility'] ?? 10;
    final uvIndex = _weatherData!['uvIndex'] ?? 8;
    final sunrise = _weatherData!['sunrise'] ?? '06:30';
    final sunset = _weatherData!['sunset'] ?? '18:45';
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Détails météorologiques',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    Icons.compress,
                    'Pression',
                    '${pressure.round()} hPa',
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    Icons.visibility,
                    'Visibilité',
                    '${visibility.round()} km',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    Icons.wb_sunny,
                    'Indice UV',
                    uvIndex.toString(),
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    Icons.schedule,
                    'Lever/Coucher',
                    '$sunrise / $sunset',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFF2E7D32),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHourlyForecast() {
    final hourlyData = _weatherData!['hourly'] ?? [];
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Prévisions horaires',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  final hour = DateTime.now().add(Duration(hours: index));
                  final temp = 25 + (index % 5) - 2; // Simulation
                  
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        Text(
                          '${hour.hour}:00',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Icon(
                          _getWeatherIcon('Ensoleillé'),
                          size: 32,
                          color: const Color(0xFF2E7D32),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${temp}°',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(index * 10) % 100}%',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue[600],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherTips() {
    final tips = _getWeatherTips();
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Conseils du jour',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 16),
            ...tips.map((tip) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tip['emoji'] ?? '🌴',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tip['text'] ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Impossible de charger les données météo',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadWeatherData,
            child: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String description) {
    switch (description.toLowerCase()) {
      case 'ensoleillé':
      case 'sunny':
        return Icons.wb_sunny;
      case 'nuageux':
      case 'cloudy':
        return Icons.cloud;
      case 'pluvieux':
      case 'rainy':
        return Icons.grain;
      case 'orageux':
      case 'stormy':
        return Icons.flash_on;
      default:
        return Icons.wb_sunny;
    }
  }

  List<Map<String, String>> _getWeatherTips() {
    final temp = _weatherData?['temperature'] ?? 25;
    final humidity = _weatherData?['humidity'] ?? 70;
    final uvIndex = _weatherData?['uvIndex'] ?? 8;
    
    List<Map<String, String>> tips = [];
    
    if (temp > 28) {
      tips.add({
        'emoji': '🌡️',
        'text': 'Température élevée, restez hydraté et évitez les efforts en plein soleil.',
      });
    }
    
    if (humidity > 80) {
      tips.add({
        'emoji': '💧',
        'text': 'Humidité importante, prévoyez des vêtements respirants.',
      });
    }
    
    if (uvIndex > 7) {
      tips.add({
        'emoji': '🧴',
        'text': 'Indice UV élevé, utilisez une protection solaire SPF 50+.',
      });
    }
    
    tips.add({
      'emoji': '🏔️',
      'text': 'Le temps peut changer rapidement en montagne, préparez-vous.',
    });
    
    return tips;
  }

  Future<void> _loadWeatherData() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      // Simulation de données météo (en production, utilisez une vraie API)
      await Future.delayed(const Duration(seconds: 1));
      
      final location = _locations.firstWhere(
        (loc) => loc['name'] == _selectedLocation,
      );
      
      setState(() {
        _weatherData = {
          'temperature': 25 + (location['lat'] * -0.5).round(),
          'description': _getRandomWeatherDescription(),
          'humidity': 65 + (location['lat'] * -2).round(),
          'windSpeed': 10 + (location['lon'] * 0.2).round(),
          'pressure': 1013 + (location['lat'] * 0.5).round(),
          'visibility': 15,
          'uvIndex': 8,
          'sunrise': '06:30',
          'sunset': '18:45',
          'hourly': [],
        };
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _weatherData = null;
      });
    }
  }

  String _getRandomWeatherDescription() {
    final descriptions = ['Ensoleillé', 'Nuageux', 'Partiellement nuageux'];
    return descriptions[DateTime.now().millisecond % descriptions.length];
  }
}