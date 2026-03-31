import 'package:dreamcatcher/src/common/widget/dream_button.dart';
import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DreamForm extends StatefulWidget {
  final Dream? initialDream;
  final Function(
    String title,
    String content,
    DateTime date,
    int clarity,
    List<String> tags,
  ) onSave;

  const DreamForm({super.key, required this.onSave, this.initialDream});

  @override
  State<DreamForm> createState() => _DreamFormState();
}

class _DreamFormState extends State<DreamForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _tagsController;

  late DateTime _selectedDate;
  late double _clarityScore;

  @override
  void initState() {
    super.initState();
    final dream = widget.initialDream;

    _titleController = TextEditingController(text: dream?.title ?? '');
    _contentController = TextEditingController(text: dream?.content ?? '');
    
    final tagsString = dream?.tags.join(', ') ?? '';
    _tagsController = TextEditingController(text: tagsString);

    _selectedDate = dream?.date ?? DateTime.now();
    _clarityScore = dream?.clarityScore.toDouble() ?? 3.0;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      final tags = _tagsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      widget.onSave(
        _titleController.text,
        _contentController.text,
        _selectedDate,
        _clarityScore.round(),
        tags,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _titleController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Title (optional)',
              labelStyle: TextStyle(color: AppTheme.sterlingSilver),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _contentController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'What did you experience?',
              labelStyle: TextStyle(color: AppTheme.sterlingSilver),
              alignLabelWithHint: true,
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
            ),
            maxLines: 5,
            validator: (value) => (value == null || value.isEmpty) ? 'Please describe your dream.' : null,
          ),
          const SizedBox(height: 24),
          
          InkWell(
            onTap: pickDate,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white24)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Date", style: TextStyle(color: AppTheme.sterlingSilver, fontSize: 12)),
                      Text(
                        "${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}",
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const Icon(Icons.calendar_today, color: AppTheme.burnishedGold, size: 20),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Klarheit: ${_clarityScore.round()} / 5", style: const TextStyle(color: AppTheme.sterlingSilver)),
              Slider(
                value: _clarityScore,
                activeColor: AppTheme.burnishedGold,
                inactiveColor: Colors.white10,
                min: 1,
                max: 5,
                divisions: 4,
                onChanged: (val) => setState(() => _clarityScore = val),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _tagsController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Tags (separate with commas)',
              labelStyle: TextStyle(color: AppTheme.sterlingSilver),
              prefixIcon: Icon(Icons.tag, color: AppTheme.sterlingSilver),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
            ),
          ),
          const SizedBox(height: 32),
          
          DreamButton(
            label: widget.initialDream == null ? 'Save Dream' : 'Save Edit',
            onPressed: submit,
          ),
        ],
      ),
    );
  }
}