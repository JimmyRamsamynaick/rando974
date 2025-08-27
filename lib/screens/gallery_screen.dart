import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String _selectedCategory = 'Tous';
  final List<String> _categories = [
    'Tous',
    'Paysages',
    'Randonnées',
    'Plages',
    'Volcans',
    'Cascades',
    'Faune',
    'Culture',
  ];

  final List<Map<String, dynamic>> _photos = [
    {
      'id': '1',
      'title': 'Piton de la Fournaise',
      'category': 'Volcans',
      'location': 'Volcan',
      'photographer': 'Marie Dubois',
      'likes': 245,
      'description': 'Vue spectaculaire du cratère principal du Piton de la Fournaise lors d\'une éruption.',
      'imageUrl': 'https://picsum.photos/400/600?random=1',
      'tags': ['volcan', 'éruption', 'cratère'],
    },
    {
      'id': '2',
      'title': 'Cirque de Mafate',
      'category': 'Paysages',
      'location': 'Mafate',
      'photographer': 'Jean Martin',
      'likes': 189,
      'description': 'Panorama du cirque de Mafate depuis le Maïdo au lever du soleil.',
      'imageUrl': 'https://picsum.photos/400/500?random=2',
      'tags': ['cirque', 'montagne', 'lever de soleil'],
    },
    {
      'id': '3',
      'title': 'Plage de l\'Ermitage',
      'category': 'Plages',
      'location': 'Saint-Paul',
      'photographer': 'Sophie Leroy',
      'likes': 156,
      'description': 'Eaux cristallines et sable blanc de la plage de l\'Ermitage.',
      'imageUrl': 'https://picsum.photos/400/400?random=3',
      'tags': ['plage', 'lagon', 'détente'],
    },
    {
      'id': '4',
      'title': 'Cascade du Voile de la Mariée',
      'category': 'Cascades',
      'location': 'Salazie',
      'photographer': 'Pierre Moreau',
      'likes': 203,
      'description': 'La majestueuse cascade du Voile de la Mariée dans le cirque de Salazie.',
      'imageUrl': 'https://picsum.photos/400/700?random=4',
      'tags': ['cascade', 'nature', 'salazie'],
    },
    {
      'id': '5',
      'title': 'Sentier du Piton des Neiges',
      'category': 'Randonnées',
      'location': 'Cilaos',
      'photographer': 'Lucie Bernard',
      'likes': 178,
      'description': 'Randonneurs sur le sentier menant au sommet du Piton des Neiges.',
      'imageUrl': 'https://picsum.photos/400/550?random=5',
      'tags': ['randonnée', 'sommet', 'effort'],
    },
    {
      'id': '6',
      'title': 'Paille-en-queue',
      'category': 'Faune',
      'location': 'Cap Méchant',
      'photographer': 'Antoine Rivière',
      'likes': 134,
      'description': 'Paille-en-queue en vol au-dessus des falaises du Cap Méchant.',
      'imageUrl': 'https://picsum.photos/400/450?random=6',
      'tags': ['oiseau', 'faune', 'vol'],
    },
    {
      'id': '7',
      'title': 'Temple tamoul',
      'category': 'Culture',
      'location': 'Saint-André',
      'photographer': 'Raj Patel',
      'likes': 167,
      'description': 'Architecture colorée d\'un temple tamoul traditionnel.',
      'imageUrl': 'https://picsum.photos/400/600?random=7',
      'tags': ['temple', 'culture', 'architecture'],
    },
    {
      'id': '8',
      'title': 'Forêt de Bélouve',
      'category': 'Paysages',
      'location': 'Hell-Bourg',
      'photographer': 'Claire Fontaine',
      'likes': 145,
      'description': 'Sentier mystérieux dans la forêt primaire de Bélouve.',
      'imageUrl': 'https://picsum.photos/400/650?random=8',
      'tags': ['forêt', 'nature', 'mystère'],
    },
    {
      'id': '9',
      'title': 'Plage de Grande Anse',
      'category': 'Plages',
      'location': 'Petite-Île',
      'photographer': 'Marc Dubois',
      'likes': 198,
      'description': 'Coucher de soleil sur la plage sauvage de Grande Anse.',
      'imageUrl': 'https://picsum.photos/400/500?random=9',
      'tags': ['coucher de soleil', 'plage sauvage'],
    },
    {
      'id': '10',
      'title': 'Trou de Fer',
      'category': 'Cascades',
      'location': 'Takamaka',
      'photographer': 'Emma Laurent',
      'likes': 221,
      'description': 'Vue aérienne du spectaculaire Trou de Fer et ses cascades.',
      'imageUrl': 'https://picsum.photos/400/750?random=10',
      'tags': ['cascade', 'vue aérienne', 'spectaculaire'],
    },
  ];

  List<Map<String, dynamic>> get _filteredPhotos {
    if (_selectedCategory == 'Tous') {
      return _photos;
    }
    return _photos.where((photo) => photo['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie Photo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategorySelector(),
          Expanded(
            child: _buildPhotoGrid(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showUploadDialog,
        backgroundColor: const Color(0xFF2E7D32),
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedCategory = category;
                  });
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

  Widget _buildPhotoGrid() {
    final filteredPhotos = _filteredPhotos;
    
    if (filteredPhotos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Aucune photo dans cette catégorie',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.75,
        ),
        itemCount: filteredPhotos.length,
        itemBuilder: (context, index) {
          final photo = filteredPhotos[index];
          return _buildPhotoCard(photo);
        },
      ),
    );
  }

  Widget _buildPhotoCard(Map<String, dynamic> photo) {
    return GestureDetector(
      onTap: () => _showPhotoDetail(photo),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: photo['imageUrl'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.error,
                        color: Colors.grey,
                        size: 50,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            photo['likes'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      photo['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            photo['location'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Par ${photo['photographer']}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPhotoDetail(Map<String, dynamic> photo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: photo['imageUrl'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 300,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    photo['title'],
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.share),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  photo['location'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.favorite,
                                  size: 16,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${photo['likes']} j\'aime',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Par ${photo['photographer']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              photo['description'],
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: (photo['tags'] as List<String>)
                                  .map((tag) => Chip(
                                        label: Text(
                                          '#$tag',
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        backgroundColor: const Color(0xFF2E7D32).withOpacity(0.1),
                                        side: const BorderSide(
                                          color: Color(0xFF2E7D32),
                                          width: 1,
                                        ),
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 20),
                          ],
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
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rechercher'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Rechercher par titre, lieu ou photographe...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Rechercher'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtres'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Trier par:'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('Plus récent'),
                  selected: false,
                  onSelected: (selected) {},
                ),
                FilterChip(
                  label: const Text('Plus populaire'),
                  selected: true,
                  onSelected: (selected) {},
                ),
                FilterChip(
                  label: const Text('Alphabétique'),
                  selected: false,
                  onSelected: (selected) {},
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Appliquer'),
          ),
        ],
      ),
    );
  }

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter une photo'),
        content: const Text(
          'Fonctionnalité à venir !\n\nVous pourrez bientôt partager vos plus belles photos de la Réunion avec la communauté.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}