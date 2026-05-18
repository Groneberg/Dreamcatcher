import 'package:dreamcatcher/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class GradientFocusInput extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const GradientFocusInput({
    super.key, 
    required this.hintText,
    required this.controller,
  });

  @override
  State<GradientFocusInput> createState() => _GradientFocusInputState();
}

class _GradientFocusInputState extends State<GradientFocusInput> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                        color: AppTheme.lavender.withAlpha(80),
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: const Offset(1, -1),
                      ),
                      BoxShadow(
                        color: AppTheme.burnishedGold.withAlpha(50),
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: const Offset(-1, 1  ),
                      ),
                    ]
                  : [],
            ),
          ),
        ),
        
        Container(
          padding: const EdgeInsets.all(1.5), 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                AppTheme.deepPurple.withAlpha(204), 
                AppTheme.lavender.withAlpha(127), 
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.navyBlue.withAlpha(40),
              borderRadius: BorderRadius.circular(19),
            ),
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              maxLines: null, 
              style: const TextStyle(color: AppTheme.lightSterlingSilver, fontSize: 16),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(color: AppTheme.lightSterlingSilver.withAlpha(150),),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(18),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}