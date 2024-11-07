import 'package:chips_input_autocomplete/src/chip_custom.dart';
import 'package:chips_input_autocomplete/src/chips_autocomplete_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double _kTextFieldWidth = 200;

/// The [ChipsInputAutocomplete] widget is a text field that allows the user to input and create chips out of it, with autocomplete support.
class ChipsInputAutocomplete extends StatefulWidget {
  /// Creates a [ChipsInputAutocomplete] widget.
  ///
  /// Read the [API reference](https://pub.dev/documentation/chips_input_autocomplete/latest/chips_input_autocomplete/chips_input_autocomplete-library.html) for full documentation.
  ///
  /// Credits to Shourya S. Ghosh for creating [Simple Chips Input](https://github.com/danger-ahead/simple_chips_input), for the inspiration and some code snippets.
  const ChipsInputAutocomplete({
    super.key,
    this.placeChipsSectionAbove = true,
    this.widgetContainerDecoration = const BoxDecoration(),
    this.spacing = 5.0,
    this.runSpacing,
    this.secondaryTheme,
    this.chipTheme,
    this.chipClipBehavior,
    this.deleteButtonTooltipMessage,
    this.paddingInsideWidgetContainer = const EdgeInsets.all(8.0),
    this.focusNode,
    this.autoFocus = false,
    this.createCharacter = ',',
    this.deleteIcon = const Padding(
      padding: EdgeInsets.only(left: 4),
      child: Icon(Icons.close, size: 16),
    ),
    this.validateInputMethod,
    this.validateChipsMethod,
    this.autovalidateMode,
    this.enabled = true,
    this.eraseKeyLabel = 'Backspace',
    this.formFieldKey,
    this.addChipOnSelection = false,
    this.onChanged,
    this.onChangedTextField,
    this.onEditingCompleteTextField,
    this.onSaved,
    this.onChipDeleted,
    this.onChipAdded,
    this.onChipsCleared,
    this.useDefaultOnChipDeleted = true,
    this.useDefaultOnChipAdded = true,
    this.useDefaultOnChipsCleared = true,
    this.showClearButton = false,
    this.clearWithConfirm = true,
    this.controller,
    this.options,
    this.initialChips,
    this.showOnlyUnselectedOptions = true,
    this.minLines = 1,
    this.enableSuggestions = true,
    this.showCursor = true,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardType = TextInputType.text,
    this.decorationTextField = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(left: 8.0),
      constraints: BoxConstraints(maxWidth: _kTextFieldWidth),
      hintText: 'Type...',
    ),
    this.optionsMaxWidth,
  });

  /// The controller for the chips, autocomplete options and textfield.
  final ChipsAutocompleteController? controller;

  /// The options for the autocomplete.
  ///
  /// Can also be set through the controller.
  final List<String>? options;

  /// The initial chips.
  final List<String>? initialChips;

  /// Whether to show only options that are not already chips.
  final bool showOnlyUnselectedOptions;

  /// The input character used for creating a chip.
  final String createCharacter;

  /// Whether to place the chips section above or below the text field.
  final bool placeChipsSectionAbove;

  /// Decoration for the main widget container.
  final BoxDecoration widgetContainerDecoration;

  /// Spacing between the chips.
  /// Defaults to 5.0.
  final double spacing;

  /// Spacing between the rows of chips.
  /// If [null], the [spacing] value will be used.
  final double? runSpacing;

  /// Whether to use the secondary theme.
  final bool? secondaryTheme;

  /// The theme for the chips.
  /// If [null], the default theme will be used.
  /// Can be set to [ChipThemeData.secondary] for a secondary theme.
  final ChipThemeData? chipTheme;

  /// Icon for the delete method.
  /// Defaults to a close icon.
  /// Can be set to null to remove the delete icon.
  final Widget? deleteIcon;

  /// The clip behavior for the chips.
  final Clip? chipClipBehavior;

  /// Tooltip message for the delete button.
  final String? deleteButtonTooltipMessage;

  /// Padding inside the main widget container;
  final EdgeInsets paddingInsideWidgetContainer;

  /// FocusNode for the text field.
  final FocusNode? focusNode;

  /// Validation method for the input.
  /// The validation method is called when a chip is added. For validating afterwards use [validateChipsMethod].
  /// Returns a [string] if the input is invalid.
  /// If [Null], the input is always valid.
  final String? Function(String?)? validateInputMethod;

  /// Validation method for the chips.
  /// The validation method is called after a chip is added. For validating when a chip is added use [validateInputMethod].
  /// Returns a [string] if the input is invalid.
  /// If [Null], the input is always valid.
  final String? Function(List<String>?)? validateChipsMethod;

  /// The autovalidate mode for the form field.
  final AutovalidateMode? autovalidateMode;

  /// Whether the form field is enabled.
  final bool enabled;

  /// The key label used for erasing a chip. Defaults to Backspace.
  final String eraseKeyLabel;

  /// Whether to autofocus the widget.
  final bool autoFocus;

  /// FormField key to access or validate the form outside the widget.
  final GlobalKey<FormFieldState<List<String>>>? formFieldKey;

  /// The style of the textfield.
  final InputDecoration decorationTextField;

  /// The maximum width of the optionsView.
  ///
  /// If not set, the width will be the same as the textfield.
  final double? optionsMaxWidth;

  /// The maximum number of lines for the text field.
  /// Currently not supported
  // final double? maxLines;

  /// The minimum number of lines for the text field.
  final int minLines;

  /// whether to show suggestions
  final bool enableSuggestions;

  /// whether to show the cursor
  final bool showCursor;

  /// The width of the cursor.
  final double cursorWidth;

  /// The height of the cursor.
  final double? cursorHeight;

  /// The radius of the cursor.
  final Radius? cursorRadius;

  /// The color to use when painting the cursor.
  final Color? cursorColor;

  /// keyboard type for the textfield
  final TextInputType keyboardType;

  /// If true, the text field will add a chip when the user selects an option. If false, selected option will be added to the text field.
  final bool addChipOnSelection;

  /// Callback when the chips value changes.
  final void Function(List<String>?)? onChanged;

  /// Callback when the text field changes.
  final void Function(String)? onChangedTextField;

  /// Callback when editing of textField is complete.
  final void Function()? onEditingCompleteTextField;

  // final void Function(String)? onSubmitted;

  /// Callback when the form is saved.
  final void Function(List<String>?)? onSaved;

  /// Callback when a chip is deleted. Returns the deleted chip content and index.
  final void Function(String, int)? onChipDeleted;

  /// Callback when a chip is added. Returns the added chip content.
  final void Function(String)? onChipAdded;

  /// Callback when all chips are cleared.
  final void Function()? onChipsCleared;

  /// Whether to use the default onChipDeleted method.
  /// Maybe set to false for a different logic. For example, when chips are updated from a different source.
  final bool useDefaultOnChipDeleted;

  /// Whether to use the default onChipAdded method.
  /// Maybe set to false for a different logic. For example, when chips are updated from a different source.
  final bool useDefaultOnChipAdded;

  /// Whether to use the default onChipsCleared method.
  /// Maybe set to false for a different logic. For example, when chips are updated from a different source.
  final bool useDefaultOnChipsCleared;

  /// Whether to show the clear button.
  final bool showClearButton;

  /// Whether to clear all chips with a confirmation dialog.
  final bool clearWithConfirm;

  /// Creates the State for the [ChipsInputAutocomplete] widget.
  @override
  State<ChipsInputAutocomplete> createState() => ChipsInputAutocompleteState();
}

/// The state for the [ChipsInputAutocomplete] widget.
class ChipsInputAutocompleteState extends State<ChipsInputAutocomplete> {
  late final ChipsAutocompleteController _chipsAutocompleteController;
  late final GlobalKey<FormFieldState<List<String>>> _formFieldKey;
  late final FocusNode _focusNode;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _formFieldKey =
        widget.formFieldKey ?? GlobalKey<FormFieldState<List<String>>>();
    _chipsAutocompleteController =
        widget.controller ?? ChipsAutocompleteController();
    _chipsAutocompleteController.formFieldKey = _formFieldKey;
    if (widget.options != null) {
      _chipsAutocompleteController.options = widget.options!;
    }
    if (widget.initialChips != null) {
      _chipsAutocompleteController.chips = widget.initialChips!;
    }
    if (widget.onChanged != null) {
      _chipsAutocompleteController.onChanged = widget.onChanged;
    }
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _chipsAutocompleteController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  _defaultOnChipDeleted(String chip, int index) {
    _chipsAutocompleteController.removeChipAt(index);
  }

  _defaultOnChipAdded(String chip) {
    _chipsAutocompleteController.addChip(chip);
  }

  _defaultOnChipsCleared() {
    _chipsAutocompleteController.clearChips();
  }

  List<Widget> _buildChipsSection() {
    final List<Widget> chips = [];
    for (int i = 0; i < _chipsAutocompleteController.chips.length; i++) {
      chips.add(ChipCustom(
        label: Text(
          _chipsAutocompleteController.chips[i],
        ),
        deleteIcon: widget.deleteIcon,
        onDeleted: () {
          setState(() {
            final chip = _chipsAutocompleteController.chips[i];
            if (widget.useDefaultOnChipDeleted) _defaultOnChipDeleted(chip, i);
            widget.onChipDeleted?.call(chip, i);
          });
        },
        secondaryTheme: widget.secondaryTheme,
        chipThemeData: widget.chipTheme,
        clipBehavior: widget.chipClipBehavior ?? Clip.none,
        // TODO: implement avatar
        // avatar: ,
        deleteButtonTooltipMessage: widget.deleteButtonTooltipMessage,
      ));
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<String>>(
      key: _formFieldKey,
      validator: widget.validateChipsMethod,
      onSaved: (value) {
        widget.onSaved?.call(value);
      },
      autovalidateMode: widget.autovalidateMode,
      enabled: widget.enabled,
      builder: (state) {
        return Container(
          padding: widget.paddingInsideWidgetContainer,
          decoration: widget.widgetContainerDecoration,
          child: SingleChildScrollView(
            child: Wrap(
              spacing: widget.spacing,
              runSpacing: widget.runSpacing ?? widget.spacing,
              children: [
                if (widget.placeChipsSectionAbove) ..._buildChipsSection(),
                KeyboardListener(
                  focusNode: FocusNode(),
                  onKeyEvent: (event) {
                    if (event is KeyUpEvent) return;
                    if (event.logicalKey.keyLabel == widget.eraseKeyLabel) {
                      if (_chipsAutocompleteController.text.isEmpty &&
                          _chipsAutocompleteController.chips.isNotEmpty) {
                        setState(() {
                          final lastChip =
                              _chipsAutocompleteController.chips.last;
                          if (widget.useDefaultOnChipDeleted) {
                            _defaultOnChipDeleted(lastChip,
                                _chipsAutocompleteController.chips.length - 1);
                          }
                          widget.onChipDeleted?.call(lastChip,
                              _chipsAutocompleteController.chips.length - 1);
                        });
                      }
                    }
                  },
                  child: FittedBox(
                    child: Row(
                      children: [
                        RawAutocomplete<String>(
                          textEditingController:
                              _chipsAutocompleteController.textController,
                          focusNode: _focusNode,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            Iterable<String> options =
                                _chipsAutocompleteController.options.where(
                              (option) => option.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase()),
                            );
                            if (widget.showOnlyUnselectedOptions) {
                              options = options.where(
                                (option) => !_chipsAutocompleteController.chips
                                    .contains(option),
                              );
                            }
                            return options;
                          },
                          onSelected: (String selection) {
                            setState(() {
                              if (widget.addChipOnSelection) {
                                if (widget.useDefaultOnChipAdded) {
                                  _defaultOnChipAdded(selection);
                                }
                                widget.onChipAdded?.call(selection);
                                _chipsAutocompleteController.clearText();
                              } else {
                                _chipsAutocompleteController
                                    .textController.text = selection;
                              }
                            });
                          },
                          fieldViewBuilder: (context, fieldController,
                              focusNode, onFieldSubmitted) {
                            return TextFormField(
                              controller: fieldController,
                              focusNode: focusNode,
                              enabled: widget.enabled,
                              autofocus: widget.autoFocus,
                              decoration: widget.decorationTextField.copyWith(
                                border: widget.decorationTextField.border ??
                                    InputBorder.none,
                                contentPadding:
                                    widget.decorationTextField.contentPadding ??
                                        const EdgeInsets.only(left: 8.0),
                                constraints:
                                    widget.decorationTextField.constraints ??
                                        const BoxConstraints(
                                            maxWidth: _kTextFieldWidth),
                                hintText: widget.decorationTextField.hintText ??
                                    'Type...',
                                errorText: _errorText,
                              ),
                              keyboardType: widget.keyboardType,
                              minLines: widget.minLines,
                              enableSuggestions: widget.enableSuggestions,
                              showCursor: widget.showCursor,
                              cursorWidth: widget.cursorWidth,
                              cursorColor: widget.cursorColor,
                              cursorRadius: widget.cursorRadius,
                              cursorHeight: widget.cursorHeight,
                              onChanged: (value) {
                                bool isCreateCharacter =
                                    value.endsWith(widget.createCharacter);
                                bool isCreateCharacterWithSpace = value
                                    .endsWith('${widget.createCharacter} ');
                                if (isCreateCharacter ||
                                    isCreateCharacterWithSpace) {
                                  _chipsAutocompleteController
                                          .textController.text =
                                      _chipsAutocompleteController
                                          .textController.text
                                          .substring(
                                              0,
                                              _chipsAutocompleteController
                                                      .textController
                                                      .text
                                                      .length -
                                                  widget
                                                      .createCharacter.length -
                                                  (isCreateCharacterWithSpace
                                                      ? 1
                                                      : 0));
                                  _chipsAutocompleteController.textController
                                      .selection = TextSelection.fromPosition(
                                    TextPosition(
                                        offset: _chipsAutocompleteController
                                            .textController.text.length),
                                  );
                                  setState(() {
                                    _errorText = widget.validateInputMethod
                                        ?.call(_chipsAutocompleteController
                                            .textController.text);
                                    if (_errorText == null) {
                                      if (widget.useDefaultOnChipAdded) {
                                        _defaultOnChipAdded(
                                            _chipsAutocompleteController
                                                .textController.text);
                                      }
                                      widget.onChipAdded?.call(
                                          _chipsAutocompleteController
                                              .textController.text);
                                      _chipsAutocompleteController.clearText();
                                    }
                                  });
                                }
                                widget.onChangedTextField?.call(value);
                              },
                              onFieldSubmitted: (String selection) =>
                                  onFieldSubmitted(),
                              onEditingComplete: () {
                                widget.onEditingCompleteTextField?.call();
                              },
                            );
                          },
                          optionsViewBuilder: (context, onSelected, options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                elevation: 4.0,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight: 200.0,
                                      maxWidth: widget.optionsMaxWidth ??
                                          widget.decorationTextField.constraints
                                              ?.maxWidth ??
                                          _kTextFieldWidth),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final String option =
                                          options.elementAt(index);
                                      return InkWell(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child: Builder(
                                          builder: (BuildContext context) {
                                            final bool highlight =
                                                AutocompleteHighlightedOption
                                                        .of(context) ==
                                                    index;
                                            // ERROR: [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: 'package:flutter/src/rendering/object.dart': Failed assertion: line 3347 pos 14: 'renderer.parent != null': is not true.
                                            // if (highlight) {
                                            //   SchedulerBinding.instance
                                            //       .addPostFrameCallback(
                                            //           (Duration timeStamp) {
                                            //     Scrollable.ensureVisible(context,
                                            //         alignment: 0.5);
                                            //   });
                                            // }
                                            return Container(
                                              color: highlight
                                                  ? Theme.of(context).focusColor
                                                  : null,
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(option),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        if (_chipsAutocompleteController.chips.isNotEmpty &&
                            widget.showClearButton)
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              if (widget.clearWithConfirm) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Clear all chips?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            setState(() {
                                              if (widget
                                                  .useDefaultOnChipsCleared) {
                                                _defaultOnChipsCleared();
                                              }
                                              widget.onChipsCleared?.call();
                                            });
                                          },
                                          child: const Text('Clear'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                setState(() {
                                  if (widget.useDefaultOnChipsCleared) {
                                    _defaultOnChipsCleared();
                                  }
                                  widget.onChipsCleared?.call();
                                });
                              }
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                if (!widget.placeChipsSectionAbove) ..._buildChipsSection(),
              ],
            ),
          ),
        );
      },
    );
  }
}
