# Chips Input Autocomplete

![GitHub stars](https://img.shields.io/github/stars/BruckCode/chips_input_autocomplete) ![GitHub license](https://img.shields.io/github/license/BruckCode/chips_input_autocomplete) [![pub package](https://img.shields.io/pub/v/chips_input_autocomplete.svg)](https://pub.dev/packages/chips_input_autocomplete)

## 📚 Table of Contents
- [Features](#-features)
- [Getting Started](#-getting-started)
- [Installation](#️-installation)
- [Usage](#️-usage)
- [Examples](#️-usage-examples)
- [Parameters](#-parameters)
- [Author](#-author)


## 🚀 Features

[//]: # (Demo under [chipsinputautocomplete.vercel.app]&#40;https://chipsinputautocomplete.vercel.app&#41;)
- **Dynamic Chip Creation:** Users can type to create chips dynamically. Ideal for tags, contacts, or any categorization.
- **Autocomplete Suggestions:** Offers suggestions as the user types, based on predefined options.
- **Customizable Appearance:** Full control over the chip's appearance, including background, border, and text colors.
- **Form Integration:** Easily integrates with forms, allowing for validation and submission of chip data.
- **Extensive Customization:** Beyond styling, customize behavior like adding chips on selection, limiting selections, and more.


## 🏁 Getting Started 
To get started with `chips_input_autocomplete`, check out the [API reference](https://pub.dev/documentation/chips_input_autocomplete/latest/chips_input_autocomplete/chips_input_autocomplete-library.html) for detailed documentation and examples.


## ⬇️ Installation 
Add `chips_input_autocomplete` to your `pubspec.yaml` file:
```yaml
dependencies:
  chips_input_autocomplete: ^<latest-version-here>
```

Then import it in your Dart code:
```dart
import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';
```

## 🛠️ Usage 

To use `chips_input_autocomplete` in your Flutter project, follow these steps:

### Basic Chip Input

This example demonstrates how to create a basic chip input field where users can type to create chips dynamically.

```dart
const List<String> yourOptionsList = ['Option 1', 'Option 2', 'Option 3'];

ChipsInputAutocomplete(
  options: yourOptionsList,
)
```

### Validate Input

Only allow chips that match predefined options. This example uses a validation method to ensure only valid options are added as chips.

```dart
ChipsInputAutocomplete(
  options: yourOptionsList,
  validateInputMethod: (String? input) {
    if (yourOptionsList.contains(input)) {
      return null; // Input is valid
    } else {
      return 'Only predefined options are allowed'; // Input is invalid
    }
  },
)
```

### Get chips data

Use a controller to get the selected chips data.

```dart
final ChipsAutocompleteController controller = ChipsAutocompleteController();

ChipsInputAutocomplete(
  controller: controller,
)

// Get selected chips data
List<String> selectedChips = controller.chips; // selectedChips = ['Chiptext 1', 'Chiptext 2']
```

### Async fetched options

Use a controller to manage the options asynchronously. This example fetches options from an API and sets them in the controller.

```dart
final ChipsAutocompleteController controller = ChipsAutocompleteController();

@override
void initState() {
  getTagsOptions();
  super.initState();
}

Future<void> getTagsOptions() async {
  controller.options = await fetchTags();
}

ChipsInputAutocomplete(
  controller: controller,
)
```

For more detailed examples and usage, refer to the [pub.dev example](https://pub.dev/packages/chips_input_autocomplete/example).

## ⚙️ Usage Examples

![Basic Demo](https://raw.githubusercontent.com/BruckCode/chips_input_autocomplete/main/demo_basic.gif)
![Demo add on selection](https://raw.githubusercontent.com/BruckCode/chips_input_autocomplete/main/demo_add_on_selection.gif)
![Demo only options allowed](https://raw.githubusercontent.com/BruckCode/chips_input_autocomplete/main/demo_only_options_allowed.gif)
![Demo async options fetched](https://raw.githubusercontent.com/BruckCode/chips_input_autocomplete/main/demo_async_fetched.gif)

## 🧷 Parameters

### Basic Configuration
- `controller`: Manages chips, autocomplete options, and the text field.
- `options`: A list of strings for autocomplete options. Can also be set via the controller.
- `createCharacter`: Character that triggers chip creation. (default: `,`)
- `separatorCharacter`: Character used to separate output chips, e.g., a comma (',').
- `placeChipsSectionAbove`: Determines if the chips section is above / left or below / right the text field.

### Chip Behavior and Appearance
- `marginBetweenChips`: Margin between chips.
- `paddingInsideChipContainer`: Padding inside each chip container.
- `chipContainerDecoration`: Decoration for the chip container.
- `chipTextStyle`: Text style for chips.
- `deleteIcon`: Icon for deleting a chip. Defaults to a close icon. Can be null to remove.

### Text Field and Input Options
- `focusNode`: FocusNode for the text field.
- `decorationTextField`: Style of the text field.
- `keyboardType`: Keyboard type for the text field.
- `enableSuggestions`: Whether to show suggestions.
- `showCursor`: Whether to show the cursor.
- `cursorWidth`: Width of the cursor.
- `cursorColor`: Color used for the cursor.
- `cursorRadius`: Radius of the cursor.
- `cursorHeight`: Height of the cursor.

### Advanced Customizations
- `widgetContainerDecoration`: Decoration for the main widget container.
- `paddingInsideWidgetContainer`: Padding inside the main widget container.
- `optionsMaxWidth`: Maximum width of the options view. Defaults to text field width if unset.
- `minLines`: Minimum number of lines for the text field.
- `autoFocus`: Whether the widget should autofocus.
- `formKey`: Form key for accessing or validating the form outside the widget.

### Validation and Selection
- `validateInputMethod`: Validation method returning a string if input is invalid. Null means always valid.
- `addChipOnSelection`: Adds a chip when an option is selected. If false, adds the option to the text field.

### Callbacks and Event Handling
- `onChanged`: Callback when the text field changes.
- `onEditingComplete`: Callback when editing is complete.
- `onSaved`: Callback when the form is saved.
- `onChipDeleted`: Callback when a chip is deleted, with chip content and index.
- `onChipAdded`: Callback when a chip is added, with chip content.
- `onChipsCleared`: Callback when all chips are cleared.
- `showClearButton`: Whether to show the clear IconButton.
- `clearWithConfirm`: Whether to show a confirmation dialog when clearing all chips.
- `eraseKeyLabel`: Key label used for erasing a chip. Defaults to Backspace.


## 🧑‍💻 Author
[@BruckCode](https://github.com/BruckCode/) [@JohannesPauli](https://github.com/HannesPaa/)