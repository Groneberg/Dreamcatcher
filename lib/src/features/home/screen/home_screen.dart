import 'package:dreamcatcher/src/common/widget/background_container.dart';
import 'package:dreamcatcher/src/common/widget/dream_fab.dart';
import 'package:dreamcatcher/src/common/widget/frosted_glass_box.dart';
import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/features/dream_details/dream_detail_screen.dart';
import 'package:dreamcatcher/src/features/quick_add/screen/quick_add_screen.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum SearchMode { none, text, tag }

class HomeScreen extends StatefulWidget {
  final DatabaseService dbService;

  const HomeScreen({super.key, required this.dbService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool _isQuickAddOpen = false;
  
  SearchMode _searchMode = SearchMode.none;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  List<String> _activeTags = [];
  List<String> _allAvailableTags = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openQuickAddScreen();
    });
    _updateAvailableTags();
  }

  @override
  void dispose() {
    _searchController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _updateAvailableTags() {
    setState(() {
      _allAvailableTags = widget.dbService.getAllUniqueTags();
    });
  }

  void _openQuickAddScreen() async {
    if (_isQuickAddOpen) return;
    _isQuickAddOpen = true;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuickAddScreen(dbService: widget.dbService),
    );

    _isQuickAddOpen = false;
    _updateAvailableTags(); 
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget appBarTitle;
    Widget? appBarPrefix;

    if (_searchMode == SearchMode.none) {
      appBarTitle = const Text('DreamCatcher');
    } else {
      appBarPrefix = Icon(
        _searchMode == SearchMode.text ? Icons.search : Icons.local_offer,
        color: AppTheme.lavender,
      );
      appBarTitle = TextField(
        controller: _searchController,
        autofocus: true,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: _searchMode == SearchMode.text
              ? "Search your subconscious..."
              : "Search tags (e.g., Lucid, Flight)...",
          hintStyle: const TextStyle(color: Colors.white38),
          border: InputBorder.none,
          prefixIcon: appBarPrefix,
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value.trim();
          });
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: appBarTitle,
        actions: [
          if (_searchMode == SearchMode.none) ...[
            IconButton(
              icon: const Icon(Icons.search, color: AppTheme.lavender),
              onPressed: () {
                setState(() => _searchMode = SearchMode.text);
              },
            ),
            IconButton(
              icon: Icon(
                _activeTags.isNotEmpty ? Icons.local_offer : Icons.local_offer_outlined,
                color: _activeTags.isNotEmpty ? AppTheme.burnishedGold : AppTheme.lavender,
              ),
              onPressed: () {
                _updateAvailableTags();
                setState(() => _searchMode = SearchMode.tag);
              },
            ),
          ] else
            IconButton(
              icon: const Icon(Icons.close, color: AppTheme.lavender),
              onPressed: () {
                setState(() {
                  _searchMode = SearchMode.none;
                  _searchController.clear();
                  _searchQuery = "";
                });
              },
            ),
        ],
      ),
      body: BackgroundContainer(
        child: SafeArea(
          child: Column(
            children: [
              if (_searchMode == SearchMode.tag) _buildTagSuggestionsPanel(),

              if (_activeTags.isNotEmpty) _buildActiveFiltersRow(),

              Expanded(
                child: StreamBuilder<List<Dream>>(
                  stream: widget.dbService.watchCombinedDreams(
                    query: _searchMode == SearchMode.text ? _searchQuery : "",
                    activeTags: _activeTags,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error loading memories.'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: AppTheme.lavender));
                    }

                    final dreams = snapshot.data ?? [];
                    if (dreams.isEmpty) {
                      return _searchMode != SearchMode.none || _activeTags.isNotEmpty
                          ? const Center(child: Text("No memories match your active filters. 🌫️"))
                          : _buildEmptyState();
                    }

                    return ListView.builder(
                      itemCount: dreams.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemBuilder: (context, index) {
                        final dream = dreams[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: FrostedGlassBox(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(
                                dream.title?.isNotEmpty == true ? dream.title! : 'Unknown Dream',
                                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  dream.content,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: AppTheme.lightSterlingSilver),
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${dream.date.day}.${dream.date.month}',
                                    style: const TextStyle(color: AppTheme.lavender, fontSize: 12),
                                  ),
                                  const SizedBox(height: 4),
                                  const Icon(Icons.chevron_right, color: AppTheme.lightSterlingSilver, size: 20),
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
                                _updateAvailableTags();
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: DreamFAB(
        onPressed: _openQuickAddScreen,
        icon: Icons.add,
      ),
    );
  }

  Widget _buildTagSuggestionsPanel() {
    final filteredTags = _allAvailableTags
        .where((tag) => tag.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    if (filteredTags.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: FrostedGlassBox(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Tap to filter by tag:",
                style: TextStyle(color: AppTheme.lightSterlingSilver, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: filteredTags.map((tag) {
                  final isSelected = _activeTags.contains(tag);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _activeTags.remove(tag);
                        } else {
                          _activeTags.add(tag);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.burnishedGold.withOpacity(0.2) : Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? AppTheme.burnishedGold : AppTheme.lavender.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: isSelected ? AppTheme.burnishedGold : Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveFiltersRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.filter_list, color: AppTheme.burnishedGold, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _activeTags.map((tag) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: InputChip(
                      label: Text(tag, style: const TextStyle(color: AppTheme.burnishedGold, fontSize: 12)),
                      backgroundColor: AppTheme.burnishedGold.withOpacity(0.1),
                      deleteIconColor: AppTheme.burnishedGold,
                      onDeleted: () {
                        setState(() => _activeTags.remove(tag));
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      side: const BorderSide(color: AppTheme.burnishedGold, width: 0.5),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          TextButton(
            onPressed: () => setState(() => _activeTags.clear()),
            child: const Text("Clear", style: TextStyle(color: AppTheme.lavender, fontSize: 12)),
          )
        ],
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
