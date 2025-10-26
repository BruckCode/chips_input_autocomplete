/*
@Author: Johannes Pauli
@License: MIT
*/

import 'dart:async';

import 'package:chips_input_autocomplete_example/example_basic.dart';
import 'package:chips_input_autocomplete_example/example_form.dart';
import 'package:chips_input_autocomplete_example/example_insert_on_select.dart';
import 'package:chips_input_autocomplete_example/example_only_options.dart';
import 'package:chips_input_autocomplete_example/constants.dart';
import 'package:chips_input_autocomplete_example/example_options_async_basic.dart';
import 'package:chips_input_autocomplete_example/example_scroll_form.dart';
import 'package:chips_input_autocomplete_example/example_secondary_theme.dart';
import 'package:flutter/material.dart';
import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';

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

  final ChipsAutocompleteController controllerExampleSecondaryTheme =
      ChipsAutocompleteController();
  String chipsOutputExampleSecondaryTheme = '';

  final ChipsAutocompleteController controllerExampleInsertOnSelect =
      ChipsAutocompleteController();
  String chipsOutputExampleInsertOnSelect = '';

  final ChipsAutocompleteController controllerExampleOnlyOptions =
      ChipsAutocompleteController();
  String chipsOutputExampleOnlyOptions = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controllerExampleBasic.addListener(() {
        setState(() {
          chipsOutputExampleBasic = controllerExampleBasic.chips.join(', ');
        });
      });
      controllerExampleSecondaryTheme.addListener(() {
        setState(() {
          chipsOutputExampleSecondaryTheme =
              controllerExampleSecondaryTheme.chips.join(', ');
        });
      });
      controllerExampleInsertOnSelect.addListener(() {
        setState(() {
          chipsOutputExampleInsertOnSelect =
              controllerExampleInsertOnSelect.chips.join(', ');
        });
      });
      controllerExampleOnlyOptions.addListener(() {
        setState(() {
          chipsOutputExampleOnlyOptions =
              controllerExampleOnlyOptions.chips.join(', ');
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
                              'Secondary Theme',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        Text('Options: ${options.join(', ')}'),
                        ChipsInputExampleSecondaryTheme(
                            controllerExampleSecondaryTheme:
                                controllerExampleSecondaryTheme),
                        Text('Selected: $chipsOutputExampleSecondaryTheme'),
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
                              controllerExampleInsertOnSelect,
                        ),
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
              const SizedBox(
                height: 16,
              ),
              const ChipsInputExampleForm(),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 400,
                child: ChipsInputExampleScrollForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
