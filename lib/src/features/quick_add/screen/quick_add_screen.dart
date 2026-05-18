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

class _QuickAddScreenState extends State<QuickAddScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
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

    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.easeInOut,
    ));
    
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

    final newDream = Dream(
      content: text,
      date: DateTime.now(),
      clarityScore: 3,
    );

    await widget.dbService.saveDream(newDream);

    if (mounted) {
      setState(() {
        _isSaving = false;
        _isSuccess = true;
      });

      await Future.delayed(const Duration(milliseconds: 800));

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dream safely saved for later... 🌙')),
        );
      }
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
                          AnimatedBuilder(
                            animation: _shakeAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(_shakeAnimation.value, 0),
                                child: child,
                              );
                            },
                            child: GradientFocusInput(
                              hintText: "Write it down before it fades...",
                              controller: _controller,
                              autofocus: true,
                            ),
                          ),
                          
                          if (_errorMessage != null) ...[
                            const SizedBox(height: 12),
                            Text(
                              _errorMessage!,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          
                          const Spacer(),
                          DreamButton(
                            label: _isSuccess 
                                ? "Saved securely! 🌟" 
                                : (_isSaving ? "Locking in the memory..." : "Add to Dreamcatcher"),
                            onPressed: (_isSaving || _isSuccess) ? () {} : _saveQuickDream,
                            isPrimary: !_isSuccess,
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