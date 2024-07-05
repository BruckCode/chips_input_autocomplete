/*
@Author: Johannes Pauli
@License: MIT
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';

const List<String> options = [
  'Apple',
  'Banana',
  'Cherry',
  'Date',
  'Elderberry'
];

const Map<int, List<String>> optionsMap = {
  0: ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'],
  1: ['Fig', 'Grape', 'Honeydew', 'Imbe', 'Jackfruit'],
  2: ['Kiwi', 'Lemon', 'Mango', 'Nectarine', 'Orange'],
  3: ['Papaya', 'Quince', 'Raspberry', 'Strawberry', 'Tangerine'],
  4: ['Ugli fruit', 'Vanilla bean', 'Watermelon', 'Ximenia', 'Yuzu'],
};

void main() {
  runApp(const FlutterDemo());
}

class FlutterDemo extends StatelessWidget {
  const FlutterDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChipsAutocompleteController controllerExampleBasic =
      ChipsAutocompleteController();
  String chipsOutputExampleBasic = '';

  final ChipsAutocompleteController controllerExampleInsertOnSelect =
      ChipsAutocompleteController();
  String chipsOutputExampleInsertOnSelect = '';

  final ChipsAutocompleteController controllerExampleOnlyOptions =
      ChipsAutocompleteController();
  String chipsOutputExampleOnlyOptions = '';

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      controllerExampleBasic.addListener(() {
        setState(() {
          chipsOutputExampleBasic = controllerExampleBasic.chips.join(', ');
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chips Input Autocomplete Demo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
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
                              'Basic Example',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        Text('Options: ${options.join(', ')}'),
                        ChipsInputExampleBasic(
                            controllerExampleBasic: controllerExampleBasic),
                        Text('Selected: $chipsOutputExampleBasic'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
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
                              'Add on selection',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            bottom: 8.0,
                          ),
                        ),
                        Text('Options: ${options.join(', ')}'),
                        ChipsInputInsertOnSelectBasic(
                            controllerExampleBasic:
                                controllerExampleInsertOnSelect),
                        Text('Selected: $chipsOutputExampleInsertOnSelect'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
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
                              'Only options allowed',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        Text('Options: ${options.join(', ')}'),
                        ChipsInputExampleOnlyOptions(
                            controllerExampleBasic:
                                controllerExampleOnlyOptions),
                        Text('Selected: $chipsOutputExampleOnlyOptions'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const ChipsInputOptionsAsyncBasic(),
            ],
          ),
        ),
      ),
    );
  }
}

class ChipsInputExampleBasic extends StatefulWidget {
  const ChipsInputExampleBasic(
      {super.key, required this.controllerExampleBasic});

  final ChipsAutocompleteController controllerExampleBasic;

  @override
  State<ChipsInputExampleBasic> createState() => _ChipsInputExampleBasicState();
}

class _ChipsInputExampleBasicState extends State<ChipsInputExampleBasic> {
  @override
  Widget build(BuildContext context) {
    return ChipsInputAutocomplete(
      controller: widget.controllerExampleBasic,
      options: options,
      decorationTextField: const InputDecoration(
        hintText: 'Type a fruit...',
      ),
    );
  }
}

class ChipsInputInsertOnSelectBasic extends StatefulWidget {
  const ChipsInputInsertOnSelectBasic(
      {super.key, required this.controllerExampleBasic});

  final ChipsAutocompleteController controllerExampleBasic;

  @override
  State<ChipsInputInsertOnSelectBasic> createState() =>
      _ChipsInputInsertOnSelectBasicState();
}

class _ChipsInputInsertOnSelectBasicState
    extends State<ChipsInputInsertOnSelectBasic> {
  @override
  Widget build(BuildContext context) {
    return ChipsInputAutocomplete(
      controller: widget.controllerExampleBasic,
      options: options,
      decorationTextField: const InputDecoration(
        hintText: 'Type a fruit...',
      ),
      addChipOnSelection: true,
    );
  }
}

class ChipsInputExampleOnlyOptions extends StatefulWidget {
  const ChipsInputExampleOnlyOptions(
      {super.key, required this.controllerExampleBasic});

  final ChipsAutocompleteController controllerExampleBasic;

  @override
  State<ChipsInputExampleOnlyOptions> createState() =>
      _ChipsInputExampleOnlyOptionsState();
}

class _ChipsInputExampleOnlyOptionsState
    extends State<ChipsInputExampleOnlyOptions> {
  @override
  Widget build(BuildContext context) {
    return ChipsInputAutocomplete(
        controller: widget.controllerExampleBasic,
        options: options,
        decorationTextField: const InputDecoration(
          hintText: 'Type a fruit...',
        ),
        validateInputMethod: (String? input) {
          if (widget.controllerExampleBasic.options.contains(input)) {
            return null;
          } else {
            return 'Only options are allowed';
          }
        });
  }
}

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
  Timer? _saveTimer;
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
