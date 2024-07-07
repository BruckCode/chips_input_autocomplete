# Chips Input Autocomplete

![GitHub stars](https://img.shields.io/github/stars/BruckCode/chips_input_autocomplete) ![GitHub license](https://img.shields.io/github/license/BruckCode/chips_input_autocomplete) [![pub package](https://img.shields.io/pub/v/chips_input_autocomplete.svg)](https://pub.dev/packages/chips_input_autocomplete)

## 📚 Table of Contents
- [Features](#-features)
- [Getting Started](#-getting-started)
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
To get started with `chips_input_autocomplete`, check out the [Installation](https://pub.dev/packages/chips_input_autocomplete/install) and [Usage](#️-usage). Detailed documentation under [API reference](https://pub.dev/documentation/chips_input_autocomplete/latest/chips_input_autocomplete/chips_input_autocomplete-library.html).


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

The appearance may differ from the current default theme. The following examples demonstrate the various configurations and behaviors of the `chips_input_autocomplete` widget. For current appearance, refer to the [pub.dev example](https://pub.dev/packages/chips_input_autocomplete/example).

![Basic Demo](https://raw.githubusercontent.com/BruckCode/chips_input_autocomplete/main/demo_basic.gif)
![Demo add on selection](https://raw.githubusercontent.com/BruckCode/chips_input_autocomplete/main/demo_add_on_selection.gif)
![Demo only options allowed](https://raw.githubusercontent.com/BruckCode/chips_input_autocomplete/main/demo_only_options_allowed.gif)
![Demo async options fetched](https://raw.githubusercontent.com/BruckCode/chips_input_autocomplete/main/demo_async_fetched.gif)

## 🧷 Parameters

### Basic Configuration
- `controller`: Manages chips, autocomplete options, and the textfield.
- `options`: A list of strings for autocomplete options. Can also be set via the controller.
- `createCharacter`: Character that triggers chip creation. (default: `,`)
- `separatorCharacter`: Character used to separate output chips. (default: `,`)
- `placeChipsSectionAbove`: Determines if the chips section is above / left or below / right the textfield.

### Chip Appearance
- `secondaryTheme`: When true, uses a secondary theme for the chips. Based on the selected chip theme of material design 3.
- `chipTheme`: Theme for the chips. Defaults to material design 3. More Details under [ChipThemeData](https://api.flutter.dev/flutter/material/ChipThemeData-class.html).
- `deleteIcon`: Icon for deleting a chip. Defaults to a close icon. Can be null to remove.
- `chipClipBehavior` : Clip behavior for the chips. (default: `Clip.none`)
- `deleteButtonTooltipMessage` : Tooltip message for the delete button. (default: `Delete`)

### Text Field Appearance and Configuration
- `focusNode`: FocusNode for the textfield.
- `decorationTextField`: Style of the textfield.
- `keyboardType`: Keyboard type for the textfield.
- `enableSuggestions`: Whether to show suggestions.
- `showCursor`: Whether to show the cursor.
- `cursorWidth`: Width of the cursor.
- `cursorColor`: Color used for the cursor.
- `cursorRadius`: Radius of the cursor.
- `cursorHeight`: Height of the cursor.

### Container Appearance
- `widgetContainerDecoration`: Decoration for the main widget container.
- `paddingInsideWidgetContainer`: Padding inside the main widget container.
- `spacing`: Spacing between chips. (default: `5.0`)
- `runSpacing`: Spacing between lines of chips. If unset, defaults to spacing.
- `optionsMaxWidth`: Maximum width of the options view. Defaults to textfield width if unset.

### Additional Configuration
- `autoFocus`: Whether the widget should autofocus.
- `formKey`: Form key for accessing or validating the form outside the widget.
- `validateInputMethod`: Validation method returning a string if input is invalid. Null means always valid.
- `addChipOnSelection`: Adds a chip when an option is selected. If false, adds the option to the text field.
- `showClearButton`: Whether to show the clear IconButton.
- `clearWithConfirm`: Whether to show a confirmation dialog when clearing all chips.
- `eraseKeyLabel`: Key label used for erasing a chip. Defaults to Backspace.

### Callbacks and Event Handling
- `onChanged`: Callback when the text field changes.
- `onEditingComplete`: Callback when editing is complete.
- `onSaved`: Callback when the form is saved.
- `onChipDeleted`: Callback when a chip is deleted, with chip content and index.
- `onChipAdded`: Callback when a chip is added, with chip content.
- `onChipsCleared`: Callback when all chips are cleared.
- `useDefaultOnChipDeleted`: Whether to use the default onChipDeleted method. Maybe set to false for a different logic. For example, when chips are updated from a different source.
- `useDefaultOnChipAdded`: Whether to use the default onChipAdded method. Maybe set to false for a different logic. For example, when chips are updated from a different source.
- `useDefaultOnChipsCleared`: Whether to use the default onChipsCleared method. Maybe set to false for a different logic. For example, when chips are updated from a different source.
## 🧑‍💻 Author
[@BruckCode](https://github.com/BruckCode/) [@JohannesPauli](https://github.com/HannesPaa/)