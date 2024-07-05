/*
@Author: Johannes Pauli
@License: MIT
*/

// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';

const List<String> options = [
  'Apple',
  'Banana',
  'Cherry',
  'Date',
  'Elderberry'
];

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
                              'Add on Selection',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            bottom: 8.0,
                          ),
                          child: Text('addChipOnSelection: true'),
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
                              'Only Options Example',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            bottom: 8.0,
                          ),
                          child: Text('''validateInputMethod: (String? input) {
            if (widget.controller.options.contains(input)) {
              return null;
            } else {
              return 'Only options are allowed';
            }
          }'''),
                        ),
                        Text('Options: ${options.join(', ')}'),
                        ChipsInputExampleOnlyOptions(
                            controllerExampleBasic: controllerExampleOnlyOptions),
                        Text('Selected: $chipsOutputExampleOnlyOptions'),
                      ],
                    ),
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
