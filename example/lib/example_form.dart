import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';
import 'package:chips_input_autocomplete_example/constants.dart';
import 'package:flutter/material.dart';

class ChipsInputExampleForm extends StatefulWidget {
  const ChipsInputExampleForm({super.key});

  @override
  State<ChipsInputExampleForm> createState() => _ChipsInputExampleFormState();
}

class _ChipsInputExampleFormState extends State<ChipsInputExampleForm> {
  final ChipsAutocompleteController controllerExampleForm =
      ChipsAutocompleteController();
  final _formKey = GlobalKey<FormState>();
  String _chipsOutput = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controllerExampleForm.addListener(() {
        setState(() {
          _chipsOutput = controllerExampleForm.chips.join(', ');
        });
      });
    });
    super.initState();
  }

  void _saveForm() {
    _formKey.currentState!.save();
  }

  void _showSnackBar(String value) {
    debugPrint('Form saved: ${controllerExampleForm.chips}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Form on saved: $value'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  child: Text(
                    'Form Example',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Options: ${options.join(', ')}'),
                        ChipsInputAutocomplete(
                          controller: controllerExampleForm,
                          options: options,
                          decorationTextField: const InputDecoration(
                            hintText: 'Type a fruit...',
                          ),
                          onSaved: (value) {
                            _showSnackBar(value?.join(', ') ?? '');
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text('Selected: $_chipsOutput'),
                        ),
                        ElevatedButton(
                          onPressed: _saveForm,
                          child: const Text('Save'),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
