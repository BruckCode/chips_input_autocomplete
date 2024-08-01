import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';
import 'package:chips_input_autocomplete_example/constants.dart';
import 'package:flutter/material.dart';

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
