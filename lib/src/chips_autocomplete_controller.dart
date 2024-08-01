import 'package:flutter/material.dart';

/// A controller for managing the state and interactions of a chips autocomplete widget.
///
/// This controller handles the addition, removal, and updating of chips as well as managing the autocomplete options.
/// It extends [ChangeNotifier] to allow listeners to rebuild when the state changes.
class ChipsAutocompleteController extends ChangeNotifier {
  /// Controller for the text field used in the autocomplete widget.
  final TextEditingController _textController = TextEditingController();

  /// The current list of autocomplete options.
  List<String> _options = [];

  /// The current list of chips added by the user.
  List<String> _chips = [];

  /// the key for the form field of chips autocomplete
  late final GlobalKey<FormFieldState<List<String>>> _formFieldKey;

  /// Gets the [TextEditingController] for the text field.
  TextEditingController get textController => _textController;

  /// Gets the current list of autocomplete options.
  List<String> get options => _options;

  /// Gets an unmodifiable view of the current list of chips.
  List<String> get chips => List.unmodifiable(_chips);

  /// Gets the current text in the autocomplete text field.
  String get text => _textController.text;

  /// Sets the list of autocomplete options and notifies listeners.
  set options(List<String> newOptions) {
    _options = newOptions;
    notifyListeners();
  }

  /// Sets the current text in the autocomplete text field and notifies listeners.
  set text(String newText) {
    _textController.text = newText;
    notifyListeners();
  }

  /// Sets the list of chips and notifies listeners.
  set chips(List<String> value) {
    _chips = value;
    _formFieldKey.currentState?.didChange(_chips);
    notifyListeners();
  }

  /// Sets the text selection within the autocomplete text field and notifies listeners.
  set selection(TextSelection value) {
    _textController.selection = value;
    notifyListeners();
  }

  /// Sets the key for the form field of chips autocomplete
  set formFieldKey(GlobalKey<FormFieldState<List<String>>> value) {
    _formFieldKey = value;
  }

  /// Adds a chip to the list and notifies listeners.
  void addChip(String chip) {
    _chips.add(chip);
    _formFieldKey.currentState?.didChange(_chips);
    notifyListeners();
  }

  /// Removes a chip at the specified index and notifies listeners.
  void removeChipAt(int index) {
    _chips.removeAt(index);
    _formFieldKey.currentState?.didChange(_chips);
    notifyListeners();
  }

  /// Clears all chips from the list and notifies listeners.
  void clearChips() {
    _chips.clear();
    _formFieldKey.currentState?.didChange(_chips);
    notifyListeners();
  }

  /// Clears the text from the autocomplete text field and notifies listeners.
  void clearText() {
    _textController.clear();
    notifyListeners();
  }

  /// Disposes the [ChipsAutocompleteController] and [TextEditingController] when the controller is disposed.
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
