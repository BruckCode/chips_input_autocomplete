import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';

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
          chipsAutocompleteController: chipsAutocompleteController,
          onChipAdded: (String chip) {
            // Verify the chip is added
            expect(chip, 'test');
          },
        ),
      ),
    ));

    // Simulate typing 'test,' to trigger chip addition
    await tester.enterText(find.byType(TextFormField), 'test,');
    await tester.pump();

    // Verify internal state is updated
    expect(chipsAutocompleteController.chips.contains('test'), true,
        reason:
            'Chip not added \nchipsAutocompleteController.chips: ${chipsAutocompleteController.chips} \nchipsAutocompleteController.text: ${chipsAutocompleteController.text}');
  });

  // Test 3: Chip Deletion
  // Similar to Test 2, simulate the erase key event and verify the chip is removed and onChipDeleted is called.

  // Test 4: Input Validation
  // Provide a custom validateInputMethod, simulate input, and verify the validator is called with the correct value.

  // Test 5: Autocomplete Suggestions
  // This requires a more complex setup to mock the options and verify only the filtered options are shown based on the input.
}
