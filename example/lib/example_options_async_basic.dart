import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';
import 'package:chips_input_autocomplete_example/constants.dart';
import 'package:flutter/material.dart';

class ChipsInputOptionsAsyncBasic extends StatefulWidget {
  const ChipsInputOptionsAsyncBasic({super.key});

  @override
  State<ChipsInputOptionsAsyncBasic> createState() =>
      _ChipsInputOptionsAsyncBasicState();
}

class _ChipsInputOptionsAsyncBasicState
    extends State<ChipsInputOptionsAsyncBasic> {
  final ChipsAutocompleteController controllerOptionsAsync =
      ChipsAutocompleteController();
  int _optionsIndex = 0;

  @override
  void initState() {
    getTagsOptions();
    super.initState();
  }

  Future<void> getTagsOptions() async {
    setState(() {
      controllerOptionsAsync.options = [];
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      controllerOptionsAsync.options = optionsMap[_optionsIndex]!;
      _optionsIndex = (_optionsIndex + 1) % optionsMap.length;
    });
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
                    'Options async fetched',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 8.0,
                ),
              ),
              Text(
                  'Options: ${controllerOptionsAsync.options.isEmpty ? 'loading...' : controllerOptionsAsync.options.join(', ')}'),
              ElevatedButton(
                onPressed: getTagsOptions,
                child: const Text('new options'),
              ),
              ChipsInputAutocomplete(
                controller: controllerOptionsAsync,
                decorationTextField: const InputDecoration(
                  hintText: 'Type a fruit...',
                ),
              ),
              Text('Selected: ${controllerOptionsAsync.chips.join(', ')}'),
            ],
          ),
        ),
      ),
    );
  }
}
