import 'package:dreamcatcher/main.dart';
import 'package:flutter/material.dart';

class DreamForm extends StatefulWidget {
  const DreamForm({super.key});

  @override
  State<DreamForm> createState() => _DreamFormState();
}

class _DreamFormState extends State<DreamForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child:  
      Column(
        spacing: 16,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Dream Titel'),
          ),
          TextFormField(),
          TextField(
            decoration: InputDecoration(labelText: 'Dream Content'),
            maxLines: 5,
          ),
          TextFormField(),
          ElevatedButton(
            onPressed: null,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
