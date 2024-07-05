import 'package:chips_input_autocomplete/src/chips_autocomplete_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double _kTextFieldWidth = 200;

/// The [ChipsInputAutocomplete] widget is a text field that allows the user to input and create chips out of it, with autocomplete support.
class ChipsInputAutocomplete extends StatefulWidget {
  /// Creates a [ChipsInputAutocomplete] widget.
  ///
  /// Read the [API reference](https://pub.dev/documentation/....html) for full documentation.
  /// Credits to Shourya S. Ghosh for creating [Simple Chips Input](https://github.com/danger-ahead/simple_chips_input), which this package is based on.
  const ChipsInputAutocomplete({
    super.key,
    this.separatorCharacter = ',',
    this.placeChipsSectionAbove = true,
    this.widgetContainerDecoration = const BoxDecoration(),
    this.marginBetweenChips =
        const EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.0),
    this.paddingInsideChipContainer =
        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
    this.paddingInsideWidgetContainer = const EdgeInsets.all(8.0),
    this.chipContainerDecoration = const BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.blue,
      borderRadius: BorderRadius.all(Radius.circular(50.0)),
    ),
    this.chipTextStyle = const TextStyle(color: Colors.white),
    this.focusNode,
    this.autoFocus = false,
    this.createCharacter = ',',
    this.deleteIcon = const Padding(
      padding: EdgeInsets.only(left: 4),
      child: Icon(Icons.close, size: 16),
    ),
    this.validateInputMethod,
    this.eraseKeyLabel = 'Backspace',
    this.formKey,
    this.addChipOnSelection = false,
    this.onChanged,
    this.onEditingComplete,
    // this.onSubmitted,
    this.onSaved,
    this.onChipDeleted,
    this.onChipAdded,
    // this.onChipsCleared,
    this.controller,
    this.options,
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

  /// Character to separate the output. For example: ' ' will separate the output by space.
  final String separatorCharacter;

  /// Whether to place the chips section above or below the text field.
  final bool placeChipsSectionAbove;

  /// Decoration for the main widget container.
  final BoxDecoration widgetContainerDecoration;

  /// Margin between the chips.
  final EdgeInsets marginBetweenChips;

  /// Padding inside the chip container.
  final EdgeInsets paddingInsideChipContainer;

  /// Padding inside the main widget container;
  final EdgeInsets paddingInsideWidgetContainer;

  /// Decoration for the chip container.
  final BoxDecoration chipContainerDecoration;

  /// FocusNode for the text field.
  final FocusNode? focusNode;

  /// The input character used for creating a chip.
  final String createCharacter;

  /// Text style for the chip.
  final TextStyle chipTextStyle;

  /// Icon for the delete method.
  /// Defaults to a close icon.
  /// Can be set to null to remove the delete icon.
  final Widget? deleteIcon;

  /// Validation method.
  /// Returns a [string] if the input is invalid.
  /// If [Null], the input is always valid.
  final String? Function(String?)? validateInputMethod;

  /// The key label used for erasing a chip. Defaults to Backspace.
  final String eraseKeyLabel;

  /// Whether to autofocus the widget.
  final bool autoFocus;

  /// Form key to access or validate the form outside the widget.
  final GlobalKey<FormState>? formKey;

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

  /// Callback when the text field changes.
  final void Function(String)? onChanged;

  final void Function()? onEditingComplete;

  // final void Function(String)? onSubmitted;

  /// Callback when the form is saved.
  final void Function(String)? onSaved;

  /// Callback when a chip is deleted. Returns the deleted chip content and index.
  final void Function(String, int)? onChipDeleted;

  /// Callback when a chip is added. Returns the added chip content.
  final void Function(String)? onChipAdded;

  /// Callback when all chips are cleared.
  /// Actually not used in the default implementation. TODO: Implement this. Maybe with trailing IconButton.
  // final void Function()? onChipsCleared;

  @override
  State<ChipsInputAutocomplete> createState() => ChipsInputAutocompleteState();
}

class ChipsInputAutocompleteState extends State<ChipsInputAutocomplete> {
  late final ChipsAutocompleteController _chipsAutocompleteController;
  late final GlobalKey<FormState> _formKey;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _chipsAutocompleteController =
        widget.controller ?? ChipsAutocompleteController();
    if (widget.options != null) {
      _chipsAutocompleteController.options = widget.options!;
    }
    _formKey = widget.formKey ?? GlobalKey<FormState>();
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

  // TODO: Implement this.
  // _defaultOnChipsCleared() {
  //   _chipsAutocompleteController.clearChips();
  // }

  List<Widget> _buildChipsSection() {
    final List<Widget> chips = [];
    for (int i = 0; i < _chipsAutocompleteController.chips.length; i++) {
      chips.add(Container(
        padding: widget.paddingInsideChipContainer,
        margin: widget.marginBetweenChips,
        decoration: widget.chipContainerDecoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                _chipsAutocompleteController.chips[i],
                style: widget.chipTextStyle,
              ),
            ),
            if (widget.deleteIcon != null)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _defaultOnChipDeleted(
                        _chipsAutocompleteController.chips[i], i);
                    widget.onChipDeleted
                        ?.call(_chipsAutocompleteController.chips[i], i);
                  });
                },
                child: widget.deleteIcon,
              ),
          ],
        ),
      ));
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: widget.paddingInsideWidgetContainer,
        decoration: widget.widgetContainerDecoration,
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              if (widget.placeChipsSectionAbove) ...[
                ..._buildChipsSection(),
              ],
              KeyboardListener(
                focusNode: FocusNode(),
                onKeyEvent: (event) {
                  if (event is KeyUpEvent) {
                    return;
                  }
                  if (event.logicalKey.keyLabel == widget.eraseKeyLabel) {
                    if (_chipsAutocompleteController.text.isEmpty &&
                        _chipsAutocompleteController.chips.isNotEmpty) {
                      setState(() {
                        final lastChip =
                            _chipsAutocompleteController.chips.last;
                        _defaultOnChipDeleted(lastChip,
                            _chipsAutocompleteController.chips.length - 1);
                        widget.onChipDeleted?.call(lastChip,
                            _chipsAutocompleteController.chips.length - 1);
                      });
                    }
                  }
                },
                child: RawAutocomplete<String>(
                  textEditingController:
                      _chipsAutocompleteController.textController,
                  focusNode: _focusNode,
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    return _chipsAutocompleteController.options.where(
                      (option) => option
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase()),
                    );
                  },
                  onSelected: (String selection) {
                    setState(() {
                      if (widget.addChipOnSelection) {
                        _defaultOnChipAdded(selection);
                        widget.onChipAdded?.call(selection);
                        _chipsAutocompleteController.clearText();
                      } else {
                        _chipsAutocompleteController.textController.text =
                            selection;
                      }
                    });
                  },
                  fieldViewBuilder:
                      (context, fieldController, focusNode, onFieldSubmitted) {
                    return TextFormField(
                      controller: fieldController,
                      focusNode: focusNode,
                      decoration: widget.decorationTextField.copyWith(
                        border: widget.decorationTextField.border ??
                            InputBorder.none,
                        contentPadding:
                            widget.decorationTextField.contentPadding ??
                                const EdgeInsets.only(left: 8.0),
                        constraints: widget.decorationTextField.constraints ??
                            const BoxConstraints(maxWidth: _kTextFieldWidth),
                        hintText: widget.decorationTextField.hintText ??
                            'Type...',
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
                        bool isCreateCharacter = value.endsWith(widget.createCharacter);
                        bool isCreateCharacterWithSpace = value.endsWith('${widget.createCharacter} ');
                        if (isCreateCharacter || isCreateCharacterWithSpace) {
                          _chipsAutocompleteController.textController.text =
                              _chipsAutocompleteController.textController.text
                                  .substring(
                                      0,
                                      _chipsAutocompleteController
                                              .textController.text.length -
                                          widget.createCharacter.length - (isCreateCharacterWithSpace ? 1 : 0));
                          _chipsAutocompleteController.textController
                              .selection = TextSelection.fromPosition(
                            TextPosition(
                                offset: _chipsAutocompleteController
                                    .textController.text.length),
                          );
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _defaultOnChipAdded(_chipsAutocompleteController
                                  .textController.text);
                              widget.onChipAdded?.call(
                                  _chipsAutocompleteController
                                      .textController.text);
                              _chipsAutocompleteController.clearText();
                            });
                          }
                        }
                        widget.onChanged?.call(value);
                      },
                      onFieldSubmitted: (String selection) =>
                          onFieldSubmitted(),
                      onEditingComplete: () {
                        widget.onEditingComplete?.call();
                      },
                      onSaved: (value) {
                        String output = '';
                        for (String text
                            in _chipsAutocompleteController.chips) {
                          output += text + widget.separatorCharacter;
                        }
                        widget.onSaved?.call(output);
                      },
                      validator: widget.validateInputMethod,
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
                            itemBuilder: (BuildContext context, int index) {
                              final String option = options.elementAt(index);
                              return InkWell(
                                onTap: () {
                                  onSelected(option);
                                },
                                child: Builder(
                                  builder: (BuildContext context) {
                                    final bool highlight =
                                        AutocompleteHighlightedOption.of(
                                                context) ==
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
                                      padding: const EdgeInsets.all(16.0),
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
              ),
              if (!widget.placeChipsSectionAbove) ...[
                ..._buildChipsSection(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
