import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';
import 'package:flutter/material.dart';

/// Example demonstrating the fix for the scroll error when using an external controller.
///
/// This example creates a scrollable form with ChipsInputAutocomplete widgets.
/// When the widget scrolls out of view and back, it should continue to work
/// without errors because the external controller is not disposed.
class ChipsInputExampleScrollForm extends StatefulWidget {
  const ChipsInputExampleScrollForm({super.key});

  @override
  State<ChipsInputExampleScrollForm> createState() =>
      _ChipsInputExampleScrollFormState();
}

class _ChipsInputExampleScrollFormState
    extends State<ChipsInputExampleScrollForm> {
  static const double _scrollSpacing = 300.0;
  
  final _formKey = GlobalKey<FormState>();
  final _companyNameController = TextEditingController();
  final _industryChipController = ChipsAutocompleteController();
  final _companyNameController2 = TextEditingController();

  final List<String> industryValues = [
    'Technology',
    'Healthcare',
    'Finance',
    'Education',
    'Manufacturing',
    'Retail',
    'Real Estate',
    'Entertainment',
    'Transportation',
    'Agriculture'
  ];

  @override
  void dispose() {
    _companyNameController.dispose();
    _industryChipController.dispose();
    _companyNameController2.dispose();
    super.dispose();
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
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Scrollable Form Example',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              Text(
                'This demonstrates the fix for the scroll error. '
                'The ChipsInputAutocomplete widget uses an external controller '
                'and can be scrolled without errors.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      // First TextField
                      TextField(
                        controller: _companyNameController,
                        decoration: const InputDecoration(
                          labelText: 'Company Name',
                          hintText: 'Enter company name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: _scrollSpacing), // Add spacing to force scrolling

                      // ChipsInputAutocomplete with external controller
                      const Text(
                        'Select Industries:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ChipsInputAutocomplete(
                        options: industryValues,
                        createCharacter: ',',
                        controller: _industryChipController,
                        widgetContainerDecoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        decorationTextField: const InputDecoration(
                          hintText: 'Type to search industries...',
                        ),
                      ),
                      const SizedBox(height: _scrollSpacing), // Add spacing to force scrolling

                      // Second TextField
                      TextField(
                        controller: _companyNameController2,
                        decoration: const InputDecoration(
                          labelText: 'Additional Info',
                          hintText: 'Enter additional information',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Submit Button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Company: ${_companyNameController.text}, '
                                  'Industries: ${_industryChipController.chips.join(', ')}',
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
