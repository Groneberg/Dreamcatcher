import 'package:dreamcatcher/src/common/widget/background_container.dart';
import 'package:dreamcatcher/src/common/widget/dream_button.dart';
import 'package:dreamcatcher/src/common/widget/frosted_glass_box.dart';
import 'package:dreamcatcher/src/common/widget/gradient_focus_input.dart';
import 'package:dreamcatcher/src/data/services/preferences_service.dart';
import 'package:dreamcatcher/src/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';

class QuickAddScreen extends StatefulWidget {
  const QuickAddScreen({super.key});

  @override
  State<QuickAddScreen> createState() => _QuickAddScreenState();
}

class _QuickAddScreenState extends State<QuickAddScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();

  DatabaseService get _dbService =>
      Provider.of<DatabaseService>(context, listen: false);
  PreferencesService get _prefsService =>
      Provider.of<PreferencesService>(context, listen: false);

  late AnimationController _shakeController;
  String? _errorMessage;
  bool _isSaving = false;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _controller.addListener(() {
      if (_errorMessage != null && _controller.text.isNotEmpty) {
        setState(() {
          _errorMessage = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _saveQuickDream() async {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      setState(() {
        _errorMessage = "A dream cannot be empty. What did you see? 🌌";
      });
      _shakeController.forward(from: 0.0);
      return;
    }

    setState(() {
      _errorMessage = null;
      _isSaving = true;
    });

    try {
      final newDream = Dream(
        content: text,
        date: DateTime.now(),
        clarityScore: 3,
      );

      await _dbService.saveDream(newDream);

      if (mounted) {
        setState(() {
          _isSaving = false;
          _isSuccess = true;
        });

        await Future.delayed(const Duration(milliseconds: 800));

        if (mounted) {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            final dbService = _dbService;
            final prefsService = _prefsService;

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => MultiProvider(
                  providers: [
                    Provider.value(value: dbService),
                    Provider.value(value: prefsService),
                  ],
                  child: const HomeScreen(isFirstLaunch: false),
                ),
              ),
            );
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Dream safely saved for later... 🌙')),
          );
        }
      }
    } catch (e) {
      debugPrint("Error saving dream: $e");

      if (mounted) {
        setState(() {
          _isSaving = false;
          _isSuccess = false;
          _errorMessage =
              "The mist is too thick. Could not secure the memory. 🌫️";
        });
        _shakeController.forward(from: 0.0);
      }
    }
  }

  Widget _buildBottomActionArea(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DreamButton(
          label: _isSuccess
              ? "Saved securely! 🌟"
              : (_isSaving
                    ? "Locking in the memory..."
                    : "Add to Dreamcatcher"),
          onPressed: (_isSaving || _isSuccess) ? () {} : _saveQuickDream,
          isPrimary: !_isSuccess,
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            minimumSize: const Size(double.infinity, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: AppTheme.lightSterlingSilver,
              fontSize: 15,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: BackgroundContainer(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.lavender.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.close,
                      color: AppTheme.lavender,
                      size: 28,
                    ),
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      } else {
                        final dbService = _dbService;
                        final prefsService = _prefsService;

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => MultiProvider(
                              providers: [
                                Provider.value(value: dbService),
                                Provider.value(value: prefsService),
                              ],
                              child: const HomeScreen(isFirstLaunch: false),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FrostedGlassBox(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GradientFocusInput(
                            hintText: "Write it down before it fades...",
                            controller: _controller,
                            autofocus: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  bottom: 24.0,
                ),
                child: _buildBottomActionArea(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
