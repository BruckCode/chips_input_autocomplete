import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';
import 'package:chips_input_autocomplete_example/constants.dart';
import 'package:flutter/material.dart';

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
