import 'package:dreamcatcher/src/common/widget/background_container.dart';
import 'package:dreamcatcher/src/common/widget/dream_fab.dart';
import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/features/dream_details/dream_detail_screen.dart';
import 'package:dreamcatcher/src/features/home/widgets/search_filter_panel.dart';
import 'package:dreamcatcher/src/features/home/widgets/dream_list.dart';
import 'package:dreamcatcher/src/features/home/widgets/filter_bar.dart';
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
  DateTimeRange? _selectedDateRange;

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
                _activeTags.isNotEmpty
                    ? Icons.local_offer
                    : Icons.local_offer_outlined,
                color: _activeTags.isNotEmpty
                    ? AppTheme.burnishedGold
                    : AppTheme.lavender,
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
              FilterBar(
                showTagSuggestions: _searchMode == SearchMode.tag,
                allAvailableTags: _allAvailableTags,
                searchQuery: _searchQuery,
                activeTags: _activeTags,
                selectedRange: _selectedDateRange,
                onToggleTag: (tag) => setState(() {
                  if (_activeTags.contains(tag)) {
                    _activeTags.remove(tag);
                  } else {
                    _activeTags.add(tag);
                  }
                }),
                onRangeSelected: (range) {
                  setState(() {
                    _selectedDateRange = range;
                  });
                },
                onClear: () => setState(() {
                  _activeTags.clear();
                  _selectedDateRange = null;
                }),
                onRemoveTag: (tag) => setState(() {
                  _activeTags.remove(tag);
                }),
              ),

              SearchFilterPanel(
                selectedRange: _selectedDateRange,
                onRangeSelected: (range) {
                  setState(() {
                    _selectedDateRange = range;
                  });
                },
              ),

              Expanded(
                child: StreamBuilder<List<Dream>>(
                  stream: widget.dbService.watchCombinedDreams(
                    textQuery: _searchMode == SearchMode.text
                        ? _searchQuery
                        : null,
                    activeTags: _activeTags,
                    selectedRange: _selectedDateRange,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error loading memories.'),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.lavender,
                        ),
                      );
                    }

                    final dreams = snapshot.data ?? [];
                    if (dreams.isEmpty) {
                      return _searchMode != SearchMode.none ||
                              _activeTags.isNotEmpty
                          ? const Center(
                              child: Text(
                                "No memories match your active filters. 🌫️",
                              ),
                            )
                          : _buildEmptyState();
                    }

                    return DreamList(
                      dreams: dreams,
                      onTap: (dream) async {
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
                      onDelete: (dream) async {
                        await widget.dbService.deleteDream(dream.id);
                        _updateAvailableTags();
                        setState(() {});
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.nights_stay,
            size: 80,
            color: AppTheme.lightSterlingSilver,
          ),
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
