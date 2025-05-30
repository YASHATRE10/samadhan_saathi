import 'package:flutter/material.dart';
import 'package:samadhan_saathi/components/app_drawer.dart';

class GovtSchemesPage extends StatelessWidget {
  const GovtSchemesPage({super.key}); // Add a const constructor

  final List<Map<String, dynamic>> schemes = const [ // Make the list const
    {
      'title': 'PM Kisan Samman Nidhi',
      'description': 'Provides income support of ₹6,000 per year to small and marginal farmer families.',
      'benefits': '₹6,000 per year in three equal installments',
      'eligibility': 'Small and marginal landholder farmer families',
      'link': 'https://pmkisan.gov.in',
      'image': 'https://images.unsplash.com/photo-1586771107445-d3ca888129ce?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Pradhan Mantri Fasal Bima Yojana (PMFBY)',
      'description': 'Crop insurance scheme to provide financial support to farmers suffering crop loss/damage.',
      'benefits': 'Premium as low as 2% for Kharif, 1.5% for Rabi crops',
      'eligibility': 'All farmers including sharecroppers and tenant farmers',
      'link': 'https://pmfby.gov.in',
      'image': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Kisan Credit Card (KCC)',
      'description': 'Provides affordable credit to farmers for their cultivation needs.',
      'benefits': 'Interest subvention of 2% and prompt repayment incentive of 3%',
      'eligibility': 'Individual farmers, tenant farmers, sharecroppers etc.',
      'link': 'https://www.nabard.org',
      'image': 'https://images.unsplash.com/photo-1560493676-04071c5f467b?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Soil Health Card Scheme',
      'description': 'Provides soil health cards to farmers every 2 years with crop-wise recommendations.',
      'benefits': 'Improved soil fertility and reduced fertilizer costs',
      'eligibility': 'All farmers across India',
      'link': 'https://soilhealth.dac.gov.in',
      'image': 'https://images.unsplash.com/photo-1605000797499-95a51c5269ae?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Paramparagat Krishi Vikas Yojana (PKVY)',
      'description': 'Promotes organic farming through cluster approach and PGS certification.',
      'benefits': 'Financial assistance of ₹50,000 per hectare/3 years',
      'eligibility': 'Farmers willing to practice organic farming',
      'link': 'https://pgsindia-ncof.gov.in',
      'image': 'https://images.unsplash.com/photo-1586773860418-d37222d8fce3?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'e-NAM (National Agricultural Market)',
      'description': 'Online trading platform for agricultural commodities to ensure better prices.',
      'benefits': 'Transparent price discovery and access to national market',
      'eligibility': 'All farmers, traders, and buyers',
      'link': 'https://www.enam.gov.in',
      'image': 'https://images.unsplash.com/photo-1556910639-8a4d4c0cdd41?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Micro Irrigation Fund (MIF)',
      'description': 'Promotes micro-irrigation to conserve water and increase productivity.',
      'benefits': 'Subsidy up to 55% for small/marginal farmers',
      'eligibility': 'Farmers adopting drip/sprinkler irrigation',
      'link': 'https://pmksy.gov.in',
      'image': 'https://images.unsplash.com/photo-1605007493699-af65834f8a05?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Agriculture Infrastructure Fund',
      'description': 'Financing facility for post-harvest infrastructure and community farming assets.',
      'benefits': '3% interest subvention and credit guarantee up to ₹2 crore',
      'eligibility': 'Farmers, FPOs, agri-entrepreneurs',
      'link': 'https://www.agriinfra.dac.gov.in',
      'image': 'https://images.unsplash.com/photo-1585016397249-9bdf2831e4d3?auto=format&fit=crop&w=800&q=80',
    },
  ];

  void _showSchemeDetails(BuildContext context, Map<String, dynamic> scheme) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scheme['title'],
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    scheme['image'],
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 180,
                        color: Colors.grey.shade200,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 180,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported, size: 40),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  scheme['description'],
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Benefits:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(scheme['benefits']),
                const SizedBox(height: 10),
                const Text(
                  'Eligibility:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(scheme['eligibility']),
                const SizedBox(height: 15),
                if (scheme['link'] != null)
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Opening ${scheme['link']}')),
                      );
                    },
                    child: Text(
                      'More Info: ${scheme['link']}',
                      style: const TextStyle(color: Colors.blue),
                    ),
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
        ),
      ),
    );
  }

  Widget _buildSchemeCard(BuildContext context, Map<String, dynamic> scheme) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => _showSchemeDetails(context, scheme),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                scheme['image'],
                height: 120,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 120,
                    color: Colors.grey.shade200,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 120,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported, size: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scheme['title'],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: const Text('View Details'),
                        backgroundColor: Colors.green[50],
                      ),
                      const Icon(Icons.arrow_forward, size: 16),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Schemes'),
        backgroundColor: Colors.green[800],
      ),
      drawer: const AppDrawer(), 
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: schemes.length,
          itemBuilder: (context, index) => _buildSchemeCard(context, schemes[index]),
        ),
      ),
    );
  }
}