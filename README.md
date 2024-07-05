# **chips_input_autocomplete**

![GitHub stars](https://img.shields.io/github/stars/BruckCode/chips_input_autocomplete) ![GitHub license](https://img.shields.io/github/license/BruckCode/chips_input_autocomplete) [![pub package](https://img.shields.io/pub/v/chips_input_autocomplete.svg)](https://pub.dev/packages/chips_input_autocomplete)

## Features 🚀
- **Dynamic Chip Creation:** Users can type to create chips dynamically. Ideal for tags, contacts, or any categorization.
- **Autocomplete Suggestions:** Offers suggestions as the user types, based on predefined options.
- **Pre-selected Chips:** Supports initializing the widget with pre-selected chips, which can be modified by the user.
- **Customizable Appearance:** Full control over the chip's appearance, including prefix/suffix icons, background, border, and text colors. Separate styles can be applied to selected and unselected chips.
- **Form Integration:** Easily integrates with forms, allowing for validation and submission of chip data.
- **Extensive Customization:** Beyond styling, customize behavior like adding chips on selection, limiting selections, and more.

## Getting Started 📚
To get started with `chips_input_autocomplete`, check out the [API reference](https://pub.dev/documentation/chips_input_autocomplete/latest/chips_input_autocomplete/chips_input_autocomplete-library.html) for detailed documentation and examples.

## Installation ⬇️
Add `chips_input_autocomplete` to your `pubspec.yaml` file:
```yaml
dependencies:
  chips_input_autocomplete: ^<latest-version-here>
```

Then import it in your Dart code:
```dart
import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';
```

## Usage 🛠️

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

### Controller with async fetched options

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

[//]: # (## Usage Examples ⚙️)

[//]: # (![Example GIF 1]&#40;https://imgur.com/1UihQSa.gif&#41;)


## Author
[@BruckCode](https://github.com/BruckCode/) [@HannesPaa](https://github.com/HannesPaa/)
```