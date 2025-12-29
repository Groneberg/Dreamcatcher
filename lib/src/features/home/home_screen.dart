import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/features/add_dream/add_dream_screen.dart';
import 'package:dreamcatcher/src/features/dream_details/dream_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
final DatabaseService dbService;

  const HomeScreen({super.key, required this.dbService});

  String _formattedDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DreamCatcher'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Dream>>(
        stream: dbService.listenToDreams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final dreams = snapshot.data ?? [];

          if (dreams.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: dreams.length,
            itemBuilder: (context, index) {
              final dream = dreams[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Text(
                      dream.clarityScore.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(dream.title ?? 'Unkown Dream'),
                  subtitle: Text(
                    dream.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    _formattedDate(dream.date),
                    style: const TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DreamDetailScreen(dream: dream, dbService: dbService),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDreamScreen(dbService: dbService),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.nights_stay, size: 64, color: Colors.grey),
          SizedBox(height: 12),
          Text('No dreams yet.', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}