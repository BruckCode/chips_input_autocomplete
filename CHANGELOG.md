# Changelog

All notable changes to this project will be documented in this file.

## 1.1.2
- added `showOnlyUnselectedOptions` to show only options that are not already selected

## 1.1.1+1
- added line spacing with `runSpacing`

## 1.1.1
- Added `useDefaultOnChipDeleted`, `useDefaultOnChipAdded`, `useDefaultOnChipsCleared` to be able to disable default behavior. Maybe set to false for a different logic. For example, when chips are updated from a different source.

## 1.1.0+1
- fixed issue with custom delete function

## 1.1.0
- added support for material 3
- Chips based now on RawChip of material 3 
- added secondary Theme based on selected Chip of material 3

## 1.0.2+3
- added documentation

## 1.0.2+2
- pubspec.yaml description extended
- formatted to match Dart Formatter

## 1.0.2+1
- added parameters to README.md
- little default design change

## 1.0.2
- added optional clear button to clear all chips

## 1.0.1+2
- added example for getting selected chips data

## 1.0.1+1
- modified README.md

## 1.0.1
- fixed auto space, for example after "," or "."
  creates a new chip also when ends with createCharacter + " "

## 1.0.0

- Initial release of the `chips_input_autocomplete` package.
- Features dynamic chip creation from user input with autocomplete suggestions.
- Supports single or multiple chip selections, with customizable appearance for chips.
- Includes form integration for validation and submission of chip data.
- Provides examples and detailed documentation for easy integration and usage.
