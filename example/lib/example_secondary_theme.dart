import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';
import 'package:chips_input_autocomplete_example/constants.dart';
import 'package:flutter/material.dart';

class ChipsInputExampleSecondaryTheme extends StatefulWidget {
  const ChipsInputExampleSecondaryTheme(
      {super.key, required this.controllerExampleSecondaryTheme});

  final ChipsAutocompleteController controllerExampleSecondaryTheme;

  @override
  State<ChipsInputExampleSecondaryTheme> createState() =>
      _ChipsInputExampleSecondaryThemeState();
}

class _ChipsInputExampleSecondaryThemeState
    extends State<ChipsInputExampleSecondaryTheme> {
  @override
  Widget build(BuildContext context) {
    return ChipsInputAutocomplete(
      secondaryTheme: true,
      controller: widget.controllerExampleSecondaryTheme,
      options: options,
      decorationTextField: const InputDecoration(
        hintText: 'Type a fruit...',
      ),
    );
  }
}
