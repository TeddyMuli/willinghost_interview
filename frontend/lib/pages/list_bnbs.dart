import 'package:flutter/material.dart';
import '../models/bnb.dart';
import '../services/get_bnbs.dart';
import '../services/delete_bnb.dart';

class BnbsPage extends StatefulWidget {
  final String title;
  const BnbsPage({Key? key, required this.title}) : super(key: key);

  @override
  State<BnbsPage> createState() => _BnbsPageState();
}

class _BnbsPageState extends State<BnbsPage> {
  late Future<List<Bnb>> _futureBnbs;

  @override
  void initState() {
    super.initState();
    _refreshBnbs();
  }

  void _refreshBnbs() {
    setState(() {
      _futureBnbs = FetchBnbs.fetchBnbs();
    });
  }

  void _navigateToAddBnb() async {
    final result = await Navigator.of(context).pushNamed('/add-bnb');
    if (result == true) _refreshBnbs();
  }

  void _navigateToEditBnb(int id) async {
    final result = await Navigator.of(
      context,
    ).pushNamed('/edit-bnb', arguments: {'id': id});
    if (result == true) _refreshBnbs();
  }

  void _navigateToBnbDetail(String id) {
    Navigator.of(context).pushNamed('/bnb-detail', arguments: {'id': id});
  }

  void _deleteBnb(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete BnB'),
        content: const Text('Are you sure you want to delete this BnB?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      final success = await DeleteBnb.deleteBnb(id);
      if (success) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('BnB deleted')));
        _refreshBnbs();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to delete BnB')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<List<Bnb>>(
        future: _futureBnbs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No BnBs available.'));
          }
          final bnbs = snapshot.data!;
          return ListView.builder(
            itemCount: bnbs.length,
            itemBuilder: (context, index) {
              final bnb = bnbs[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  onTap: () => _navigateToBnbDetail(bnb.id.toString()),
                  title: Text(bnb.name),
                  subtitle: Text(
                    'Location: ${bnb.location}\nPrice: ${bnb.pricePerNight}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      bnb.availability
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : const Icon(Icons.cancel, color: Colors.red),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            _navigateToEditBnb(bnb.id);
                          } else if (value == 'delete') {
                            _deleteBnb(bnb.id);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddBnb,
        child: const Icon(Icons.add),
        tooltip: 'Create BnB',
      ),
    );
  }
}
