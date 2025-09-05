import 'package:flutter/material.dart';
import '../models/bnb.dart';
import '../services/get_bnb.dart';

class BnbDetailPage extends StatelessWidget {
  final String bnbId;
  const BnbDetailPage({Key? key, required this.bnbId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BnB Details')),
      body: FutureBuilder<Bnb>(
        future: FetchBnb.fetchBnb(bnbId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('BnB not found.'));
          }
          final bnb = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bnb.name, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 12),
                Text('Location: ${bnb.location}', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Price per Night: ${bnb.pricePerNight}', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Available: '),
                    Icon(
                      bnb.availability ? Icons.check_circle : Icons.cancel,
                      color: bnb.availability ? Colors.green : Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text('ID: ${bnb.id}', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          );
        },
      ),
    );
  }
}
