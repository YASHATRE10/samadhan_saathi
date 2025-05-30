import 'package:flutter/material.dart';
import 'package:samadhan_saathi/components/app_drawer.dart';

class MiniSahyadriPage extends StatelessWidget {
  const MiniSahyadriPage({super.key}); 

  final List<Map<String, dynamic>> newsItems = const [
    {
      'title': 'Farmers advised on upcoming monsoon patterns',
      'date': '2025-05-28',
      'summary': 'Meteorological department predicts good rainfall this season.',
      'description':
          'The meteorological department has predicted a timely and adequate monsoon for this year...',
      'imageUrl':
          'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=800&q=80',
      'videoUrl': null,
    },
    {
      'title': 'Crop disease alert in western region',
      'date': '2025-05-27',
      'summary': 'Farmers urged to monitor for signs of leaf blight.',
      'description': 'An outbreak of leaf blight disease has been reported...',
      'imageUrl':
          'https://images.unsplash.com/photo-1528825871115-3581a5387919?auto=format&fit=crop&w=800&q=80',
      'videoUrl':
          'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
    },
    {
      'title': 'New Subsidy Scheme for Organic Fertilizers Launched',
      'date': '2025-05-26',
      'summary':
          'Farmers can apply online for fertilizer subsidies starting this week.',
      'description':
          'The Agriculture Ministry has launched a new subsidy scheme for organic fertilizers. '
          'This aims to promote sustainable agriculture and improve soil health. Eligible farmers can apply online or at local Krishi offices.',
      'imageUrl':
          'https://images.unsplash.com/photo-1587202372775-df60e9dd344c?auto=format&fit=crop&w=800&q=80',
      'videoUrl': null,
    },
    {
      'title': 'Rainwater Harvesting Workshop for Farmers in Maharashtra',
      'date': '2025-05-25',
      'summary': 'Free workshop on rainwater harvesting to be held in Nashik.',
      'description':
          'A free hands-on training session on building rainwater harvesting systems will be conducted in Nashik on June 2. '
          'Farmers interested in sustainable irrigation techniques are encouraged to register early.',
      'imageUrl':
          'https://images.unsplash.com/photo-1615399126937-7b9ed88e216e?auto=format&fit=crop&w=800&q=80',
      'videoUrl': null,
    },
    {
      'title': 'Drone Technology Being Used for Crop Monitoring',
      'date': '2025-05-24',
      'summary': 'Pilot project uses drones to monitor crop health in Satara.',
      'description':
          'The agriculture department in Satara has begun testing drones to monitor crop health, irrigation efficiency, and pest infestation. '
          'The initiative aims to reduce inspection time and improve accuracy of reports.',
      'imageUrl':
          'https://images.unsplash.com/photo-1581091012184-5c835b2b0e0b?auto=format&fit=crop&w=800&q=80',
      'videoUrl': null,
    },
    {
      'title': 'Wheat Procurement Price Increased for 2025 Season',
      'date': '2025-05-23',
      'summary': 'MSP for wheat has been raised by ₹150/quintal this year.',
      'description':
          'The government has announced an increase in the Minimum Support Price (MSP) for wheat. '
          'This move is expected to benefit over 6 million wheat farmers across India during the 2025 harvest season.',
      'imageUrl':
          'https://images.unsplash.com/photo-1571687949920-e3f6f097b498?auto=format&fit=crop&w=800&q=80',
      'videoUrl': null,
    },
  ];

  void _showNewsDetails(BuildContext context, Map<String, dynamic> news) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: news['imageUrl'] != null &&
                          news['imageUrl'].toString().isNotEmpty
                      ? Image.network(
                          news['imageUrl'],
                          height: 180,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 180,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.broken_image,
                                size: 50, color: Colors.grey),
                          ),
                        )
                      : Container(
                          height: 180,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image_not_supported,
                              size: 50, color: Colors.grey),
                        ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news['title'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        news['date'],
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 12),
                      Text(news['description']),
                      const SizedBox(height: 12),
                      if (news['videoUrl'] != null)
                        Text(
                          'Video URL: ${news['videoUrl']}',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, Map<String, dynamic> news) {
    return GestureDetector(
      onTap: () => _showNewsDetails(context, news),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: news['imageUrl'] != null &&
                      news['imageUrl'].toString().isNotEmpty
                  ? Image.network(
                      news['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: Colors.grey.shade300),
                    )
                  : Container(color: Colors.grey.shade300),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news['title'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [Shadow(blurRadius: 5, color: Colors.black)]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    news['summary'],
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        shadows: [Shadow(blurRadius: 5, color: Colors.black)]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Sahyadri News'),
        backgroundColor: Colors.green[800],
      ),
      drawer: const AppDrawer(), 
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemCount: newsItems.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
              _buildNewsCard(context, newsItems[index]),
        ),
      ),
    );
  }
}