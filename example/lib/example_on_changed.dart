import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';
import 'package:chips_input_autocomplete_example/constants.dart';
import 'package:flutter/material.dart';

/// Example demonstrating the use of ChipsInputAutocomplete with an external
/// controller and onChange callback that triggers setState in parent widget.
///
/// This example specifically tests the fix for the issue where rendering went
/// weird when both controller and onChange callback were set.
class ChipsInputExampleOnChanged extends StatefulWidget {
  const ChipsInputExampleOnChanged({super.key});

  @override
  State<ChipsInputExampleOnChanged> createState() =>
      _ChipsInputExampleOnChangedState();
}

class _ChipsInputExampleOnChangedState
    extends State<ChipsInputExampleOnChanged> {
  final ChipsAutocompleteController _controller = ChipsAutocompleteController();
  String _selectedChipsText = '';
  int _changeCount = 0;

  @override
  void dispose() {
    _controller.dispose();
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
              Text(
                'External Controller with onChange',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'This example uses an external controller and onChange callback '
                'that triggers setState. This previously caused rendering issues '
                'but is now fixed.',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),
              Text('Options: ${options.join(', ')}'),
              const SizedBox(height: 8),
              ChipsInputAutocomplete(
                controller: _controller,
                options: options,
                decorationTextField: const InputDecoration(
                  hintText: 'Type a fruit...',
                ),
                onChanged: (chips) {
                  // This setState call previously caused issues
                  setState(() {
                    _selectedChipsText = chips?.join(', ') ?? '';
                    _changeCount++;
                  });
                },
              ),
              const SizedBox(height: 8),
              Text('Selected: $_selectedChipsText'),
              Text('Changes: $_changeCount'),
            ],
          ),
        ),
      ),
    );
  }
}
