import 'package:chips_input_autocomplete/src/chip_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';

const kCreateCharacter = ',';

void main() {
  // Test 1: Initialization
  testWidgets('Widget initializes with default values',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: ChipsInputAutocomplete(),
      ),
    ));

    // Verify the widget is present in the tree
    expect(find.byType(ChipsInputAutocomplete), findsOneWidget);
  });

  // Test 2: Chip Addition
  testWidgets('Adding a chip updates the widget state and calls onChipAdded',
      (WidgetTester tester) async {
    // Define a key to interact with the widget
    final key = GlobalKey<ChipsInputAutocompleteState>();
    final chipsAutocompleteController = ChipsAutocompleteController();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ChipsInputAutocomplete(
          key: key,
          controller: chipsAutocompleteController,
          createCharacter: kCreateCharacter,
          onChipAdded: (String chip) {
            // Verify the chip is added
            expect(chip, 'test');
          },
        ),
      ),
    ));

    // Simulate typing 'test,' to trigger chip addition
    await tester.enterText(find.byType(TextFormField), 'test$kCreateCharacter');
    await tester.pump();

    // Verify internal state is updated
    expect(chipsAutocompleteController.chips.contains('test'), true,
        reason:
            'Chip not added \nchipsAutocompleteController.chips: ${chipsAutocompleteController.chips} \nchipsAutocompleteController.text: ${chipsAutocompleteController.text}');
  });
}
