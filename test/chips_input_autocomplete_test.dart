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

  // Test 3: Controller disposal - external controller should not be disposed
  testWidgets(
      'External controller should not be disposed when widget is disposed',
      (WidgetTester tester) async {
    final externalController = ChipsAutocompleteController();
    
    // Verify controller is not disposed initially
    expect(() => externalController.chips, returnsNormally);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            SizedBox(height: 1000), // Force scrolling
            ChipsInputAutocomplete(
              controller: externalController,
              options: const ['option1', 'option2'],
            ),
            SizedBox(height: 1000),
          ],
        ),
      ),
    ));

    // Verify controller works
    expect(() => externalController.chips, returnsNormally);

    // Remove the widget by replacing with a different widget
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Text('Replaced'),
      ),
    ));

    // Verify the external controller is still usable after widget disposal
    expect(() => externalController.chips, returnsNormally);
    expect(() => externalController.addChip('test'), returnsNormally);
    expect(externalController.chips.contains('test'), true);

    // Clean up
    externalController.dispose();
  });

  // Test 4: FocusNode disposal - external FocusNode should not be disposed
  testWidgets(
      'External FocusNode should not be disposed when widget is disposed',
      (WidgetTester tester) async {
    final externalFocusNode = FocusNode();
    
    // Verify FocusNode is not disposed initially
    expect(externalFocusNode.hasFocus, isFalse);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ChipsInputAutocomplete(
          focusNode: externalFocusNode,
          options: const ['option1', 'option2'],
        ),
      ),
    ));

    // Remove the widget
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Text('Replaced'),
      ),
    ));

    // Verify the external FocusNode is still usable after widget disposal
    expect(() => externalFocusNode.hasFocus, returnsNormally);

    // Clean up
    externalFocusNode.dispose();
  });

  // Test 5: Scroll test - widget with external controller in scrollable list
  testWidgets(
      'Widget with external controller should work correctly in scrollable list',
      (WidgetTester tester) async {
    final controller = ChipsAutocompleteController();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            const TextField(
              decoration: InputDecoration(hintText: 'Field 1'),
            ),
            const SizedBox(height: 500),
            ChipsInputAutocomplete(
              controller: controller,
              options: const ['Apple', 'Banana', 'Cherry'],
              widgetContainerDecoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 500),
            const TextField(
              decoration: InputDecoration(hintText: 'Field 2'),
            ),
          ],
        ),
      ),
    ));

    // Add a chip
    controller.addChip('Apple');
    await tester.pump();
    
    expect(controller.chips.contains('Apple'), true);

    // Scroll down so the widget goes out of view
    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();

    // Verify controller is still working
    expect(() => controller.chips, returnsNormally);
    expect(controller.chips.contains('Apple'), true);

    // Scroll back up
    await tester.drag(find.byType(ListView), const Offset(0, 600));
    await tester.pumpAndSettle();

    // Verify widget is still functional
    expect(controller.chips.contains('Apple'), true);
    controller.addChip('Banana');
    await tester.pump();
    expect(controller.chips.length, 2);

    // Clean up
    controller.dispose();
  });
}
