import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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

  // Test 3: External controller with onChange should not cause disposal issues
  testWidgets(
      'Widget with external controller and onChange callback handles rebuilds correctly',
      (WidgetTester tester) async {
    final chipsAutocompleteController = ChipsAutocompleteController();
    int onChangedCallCount = 0;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: StatefulBuilder(
          builder: (context, setState) {
            return ChipsInputAutocomplete(
              controller: chipsAutocompleteController,
              createCharacter: kCreateCharacter,
              onChanged: (chips) {
                onChangedCallCount++;
                // Trigger a rebuild in the parent widget
                setState(() {});
              },
            );
          },
        ),
      ),
    ));

    // Simulate typing 'test,' to trigger chip addition and onChange
    await tester.enterText(find.byType(TextFormField), 'test$kCreateCharacter');
    await tester.pump();

    // Verify the chip was added
    expect(chipsAutocompleteController.chips.contains('test'), true);
    expect(onChangedCallCount, 1);

    // Simulate adding another chip to verify controller is still functional
    await tester.enterText(find.byType(TextFormField), 'test2$kCreateCharacter');
    await tester.pump();

    // Verify the second chip was added
    expect(chipsAutocompleteController.chips.contains('test2'), true);
    expect(onChangedCallCount, 2);
  });

  // Test 4: External controller should not be disposed when widget is disposed
  testWidgets('External controller should not be disposed when widget is disposed',
      (WidgetTester tester) async {
    final chipsAutocompleteController = ChipsAutocompleteController();
    
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ChipsInputAutocomplete(
          controller: chipsAutocompleteController,
        ),
      ),
    ));

    // Verify the widget is present
    expect(find.byType(ChipsInputAutocomplete), findsOneWidget);

    // Remove the widget from the tree
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: SizedBox(),
      ),
    ));

    // Verify the controller is still functional after widget disposal
    expect(() => chipsAutocompleteController.chips, returnsNormally);
    expect(() => chipsAutocompleteController.addChip('test'), returnsNormally);
    expect(chipsAutocompleteController.chips.contains('test'), true);

    // Clean up
    chipsAutocompleteController.dispose();
  });

  // Test 5: Internal controller should be disposed when widget is disposed
  testWidgets('Internal controller should be disposed when widget is disposed',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: ChipsInputAutocomplete(),
      ),
    ));

    // Verify the widget is present
    expect(find.byType(ChipsInputAutocomplete), findsOneWidget);

    // Remove the widget from the tree
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: SizedBox(),
      ),
    ));

    // Widget disposal should not throw any errors
    // (Internal controller is properly disposed)
  });
}
