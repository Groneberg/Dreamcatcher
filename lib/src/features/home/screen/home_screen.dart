import 'package:dreamcatcher/src/common/widget/background_container.dart';
import 'package:dreamcatcher/src/common/widget/dream_fab.dart';
import 'package:dreamcatcher/src/common/widget/frosted_glass_box.dart';
import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/features/dream_details/dream_detail_screen.dart';
import 'package:dreamcatcher/src/features/quick_add/screen/quick_add_screen.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final DatabaseService dbService;

  const HomeScreen({super.key, required this.dbService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool _isQuickAddOpen = false;
  List<Dream> _dreams = [];

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'DreamCatcher',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BackgroundContainer(
        child: SafeArea(
          child: StreamBuilder<List<Dream>>(
            stream: widget.dbService.listenToDreams(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.cloud_off, color: Colors.redAccent, size: 48),
                        const SizedBox(height: 16),
                        const Text(
                          "Your dreams are temporarily hidden in the mist.",
                          style: TextStyle(color: AppTheme.lightSterlingSilver, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Error: ${snapshot.error}",
                          style: const TextStyle(color: Colors.white24, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData) {
                _dreams = snapshot.data!;
              }

              final dreams = _dreams;

              if (dreams.isEmpty) {
                return _buildEmptyState();
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: dreams.length,
                itemBuilder: (context, index) {
                  final dream = dreams[index];

                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12.0,
                    ),
                    child: Dismissible(
                      key: Key(dream.id.toString()),

                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: Colors.red.withAlpha(150),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),

                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) async {
                        final dreamToDelete = dream;
                        setState(() {
                          _dreams.removeAt(index);
                        });
                        await widget.dbService.deleteDream(dreamToDelete.id);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Dream dissolved into the void... 🌌')),
                          );
                        }
                      },
                      child: FrostedGlassBox(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          title: Text(
                            dream.title ?? 'Unkown Dream',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            dream.content,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppTheme.lightSterlingSilver.withAlpha(200),
                              height: 1.4,
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _formattedDate(dream.date),
                                style: const TextStyle(
                                  color: AppTheme.burnishedGold,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Icon(
                                Icons.chevron_right,
                                color: Colors.white54,
                                size: 20,
                              ),
                            ],
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DreamDetailScreen(
                                  dream: dream,
                                  dbService: widget.dbService,
                                ),
                              ),
                            );
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: DreamFAB(
        onPressed: _openQuickAddScreen,
        icon: Icons.add,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.nights_stay, size: 80, color: AppTheme.lightSterlingSilver),
          SizedBox(height: 16),
          Text(
            'Your dreamcatcher is empty.',
            style: TextStyle(
              fontSize: 20,
              color: AppTheme.lightSterlingSilver,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
