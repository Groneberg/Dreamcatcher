import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/features/dream_details/dream_detail_screen.dart';
import 'package:dreamcatcher/src/features/quick_add/screen/quick_add_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final DatabaseService dbService;

  const HomeScreen({super.key, required this.dbService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  
  bool _isQuickAddOpen = false; 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openQuickAddScreen();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _openQuickAddScreen();
    }
  }

  Future<void> _openQuickAddScreen() async {
    if (_isQuickAddOpen) return; 

    _isQuickAddOpen = true;
    
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuickAddScreen(dbService: widget.dbService),
      ),
    );

    _isQuickAddOpen = false;
  }

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
        stream: widget.dbService.listenToDreams(),
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
              return Dismissible(
                key: Key(dream.id.toString()),
                child: Card(
                  child: ListTile(
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
                          builder: (context) => DreamDetailScreen(
                            dream: dream, 
                            dbService: widget.dbService
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openQuickAddScreen,
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