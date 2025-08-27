import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class HikingScreen extends StatefulWidget {
  const HikingScreen({super.key});

  @override
  State<HikingScreen> createState() => _HikingScreenState();
}

class _HikingScreenState extends State<HikingScreen> {
  String _selectedDifficulty = 'Toutes';
  
  final List<String> _difficulties = [
    'Toutes',
    'Facile',
    'Modéré',
    'Difficile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Randonnées'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showHikingTips,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildDifficultyFilter(),
          Expanded(
            child: _buildHikingList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyFilter() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _difficulties.length,
        itemBuilder: (context, index) {
          final difficulty = _difficulties[index];
          final isSelected = difficulty == _selectedDifficulty;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(difficulty),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedDifficulty = difficulty;
                });
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

  Widget _buildHikingList() {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final filteredTrails = _selectedDifficulty == 'Toutes'
            ? appState.hikingTrails
            : appState.hikingTrails
                .where((trail) => trail['difficulty'] == _selectedDifficulty)
                .toList();

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredTrails.length,
          itemBuilder: (context, index) {
            final trail = filteredTrails[index];
            return _buildTrailCard(trail);
          },
        );
      },
    );
  }

  Widget _buildTrailCard(Map<String, dynamic> trail) {
    Color difficultyColor;
    IconData difficultyIcon;
    
    switch (trail['difficulty']) {
      case 'Facile':
        difficultyColor = Colors.green;
        difficultyIcon = Icons.terrain;
        break;
      case 'Modéré':
        difficultyColor = Colors.orange;
        difficultyIcon = Icons.landscape;
        break;
      case 'Difficile':
        difficultyColor = Colors.red;
        difficultyIcon = Icons.filter_hdr;
        break;
      default:
        difficultyColor = Colors.grey;
        difficultyIcon = Icons.hiking;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => _showTrailDetails(trail),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF2E7D32).withOpacity(0.8),
                      const Color(0xFF4CAF50).withOpacity(0.6),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        trail['image'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF2E7D32),
                            child: const Center(
                              child: Icon(
                                Icons.hiking,
                                size: 60,
                                color: Colors.white54,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: difficultyColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              difficultyIcon,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              trail['difficulty'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trail['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    trail['description'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildInfoChip(
                        Icons.access_time,
                        trail['duration'],
                        Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        Icons.straighten,
                        trail['distance'],
                        Colors.purple,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showTrailDetails(Map<String, dynamic> trail) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.3,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFF2E7D32).withOpacity(0.8),
                                  const Color(0xFF4CAF50).withOpacity(0.6),
                                ],
                              ),
                            ),
                            child: Image.asset(
                              trail['image'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFF2E7D32),
                                  child: const Center(
                                    child: Icon(
                                      Icons.hiking,
                                      size: 60,
                                      color: Colors.white54,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          trail['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          trail['description'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildDetailSection('Informations pratiques', [
                          _buildDetailRow(Icons.access_time, 'Durée', trail['duration']),
                          _buildDetailRow(Icons.straighten, 'Distance', trail['distance']),
                          _buildDetailRow(Icons.terrain, 'Difficulté', trail['difficulty']),
                        ]),
                        const SizedBox(height: 20),
                        _buildDetailSection('Conseils', [
                          _buildTipItem('💧', 'Emportez suffisamment d\'eau (1,5L minimum)'),
                          _buildTipItem('👟', 'Portez des chaussures de randonnée adaptées'),
                          _buildTipItem('🌤️', 'Vérifiez la météo avant de partir'),
                          _buildTipItem('📱', 'Informez quelqu\'un de votre itinéraire'),
                          _buildTipItem('🎒', 'Emportez une trousse de premiers secours'),
                        ]),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              _showSafetyReminder();
                            },
                            icon: const Icon(Icons.hiking),
                            label: const Text('Commencer la randonnée'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E7D32),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: const Color(0xFF2E7D32),
          ),
          const SizedBox(width: 12),
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String emoji, String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showHikingTips() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Conseils de sécurité',
          style: TextStyle(
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTipItem('⚠️', 'Ne partez jamais seul en randonnée'),
            _buildTipItem('🌦️', 'Attention aux changements météo rapides'),
            _buildTipItem('🐍', 'Restez sur les sentiers balisés'),
            _buildTipItem('📞', 'Numéro d\'urgence: 15 (SAMU) ou 18 (Pompiers)'),
            _buildTipItem('🕐', 'Partez tôt le matin pour éviter la chaleur'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Compris'),
          ),
        ],
      ),
    );
  }

  void _showSafetyReminder() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Rappel de sécurité',
          style: TextStyle(
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'N\'oubliez pas d\'informer quelqu\'un de votre itinéraire et de votre heure de retour prévue. Bonne randonnée !',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('J\'ai compris'),
          ),
        ],
      ),
    );
  }
}