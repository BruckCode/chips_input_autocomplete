import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';
import 'package:chips_input_autocomplete_example/constants.dart';
import 'package:flutter/material.dart';

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
