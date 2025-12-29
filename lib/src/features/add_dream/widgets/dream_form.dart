import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:flutter/material.dart';

class DreamForm extends StatefulWidget {
  final Dream? initialDream;
  final Function(
    String title,
    String content,
    DateTime date,
    int clarity,
    List<String> tags,
  )
  onSave;

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
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      // TODO Tags are split by comma and trimmed and stored as List<String>
      final tagsList = _tagsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      widget.onSave(
        _titleController.text,
        _contentController.text,
        _selectedDate,
        _clarityScore.round(),
        tagsList,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "Date: ${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.calendar_today),
            onTap: pickDate,
          ),

          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title of the Dream',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.title),
            ),
            textInputAction: TextInputAction.next,
          ),

          TextFormField(
            controller: _contentController,
            decoration: const InputDecoration(
              labelText: 'What happend?',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please describe your dream.';
              }
              return null;
            },
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Clarity: ${_clarityScore.round()} / 5"),
              Slider(
                value: _clarityScore,
                min: 1,
                max: 5,
                divisions: 4,
                label: _clarityScore.round().toString(),
                onChanged: (val) => setState(() => _clarityScore = val),
              ),
            ],
          ),

          TextFormField(
            controller: _tagsController,
            decoration: const InputDecoration(
              labelText: 'Tags (separate with commas)',
              hintText: 'e.g., flying, water, nightmare',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.tag),
            ),
          ),

          ElevatedButton(
            onPressed: submit,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Save Dream', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
