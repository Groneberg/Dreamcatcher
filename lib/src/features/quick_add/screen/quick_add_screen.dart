// lib/src/features/quick_add/quick_add_screen.dart
import 'package:dreamcatcher/src/common/widget/background_container.dart';
import 'package:dreamcatcher/src/common/widget/frosted_glass_box.dart';
import 'package:dreamcatcher/src/common/widget/gradient_focus_input.dart';
import 'package:flutter/material.dart';

import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';

class QuickAddScreen extends StatefulWidget {
  final DatabaseService dbService;

  const QuickAddScreen({super.key, required this.dbService});

  @override
  State<QuickAddScreen> createState() => _QuickAddScreenState();
}

class _QuickAddScreenState extends State<QuickAddScreen> {
  final TextEditingController _controller = TextEditingController();

  void _saveQuickDream() async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      Navigator.pop(context);
      return;
    }

    final newDream = Dream(
      content: text,
      date: DateTime.now(),
      clarityScore: 3,
    );

    await widget.dbService.saveDream(newDream);

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dream safely saved for later... 🌙')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BackgroundContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "What did you dream?",
                  style: TextStyle(
                    color: AppTheme.sterlingSilver,
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: FrostedGlassBox(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: GradientFocusInput(
                              hintText: "Write it down before it fades...",
                              controller: _controller,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _saveQuickDream,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.burnishedGold,
                              foregroundColor: AppTheme.navyBlue,
                              minimumSize: const Size(double.infinity, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "Add to Dreamcatcher",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}