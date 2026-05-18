import 'package:dreamcatcher/src/common/widget/background_container.dart';
import 'package:dreamcatcher/src/common/widget/dream_button.dart';
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
          icon: const Icon(Icons.close, color: AppTheme.lightSterlingSilver),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BackgroundContainer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "What did you dream?",
                    style: TextStyle(
                      color: AppTheme.lightSterlingSilver,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 30),
                  FrostedGlassBox(
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          GradientFocusInput(
                            hintText: "Write it down before it fades...",
                            controller: _controller,
                          ),
                          const Spacer(),
                          DreamButton(
                            label: "Add to Dreamcatcher",
                            onPressed: _saveQuickDream,
                            isPrimary: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}