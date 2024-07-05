import 'package:flutter/material.dart';

class ChipsAutocompleteController extends ChangeNotifier {
  final TextEditingController _textController = TextEditingController();
  List<String> _options = [];
  List<String> _chips = [];

  TextEditingController get textController => _textController;

  List<String> get options => _options;

  List<String> get chips => List.unmodifiable(_chips);

  String get text => _textController.text;

  set options(List<String> newOptions) {
    _options = newOptions;
    notifyListeners();
  }

  set text(String newText) {
    _textController.text = newText;
    notifyListeners();
  }

  set chips(List<String> value) {
    _chips = value;
    notifyListeners();
  }

  set selection(TextSelection value) {
    _textController.selection = value;
    notifyListeners();
  }

  void addChip(String chip) {
    _chips.add(chip);
    notifyListeners();
  }

  void removeChipAt(int index) {
    _chips.removeAt(index);
    notifyListeners();
  }

  void clearChips() {
    _chips.clear();
    notifyListeners();
  }

  void clearText() {
    _textController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}