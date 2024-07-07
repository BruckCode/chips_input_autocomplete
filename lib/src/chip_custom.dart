import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A customizable chip widget that can be used within Flutter applications.
///
/// This widget allows for the creation of chips with various customizations such as themes, avatars,
/// deletion icons, and more. It is designed to be flexible and integrate with different UI designs.
class ChipCustom extends StatelessWidget {
  /// Determines if the secondary theme should be applied to the chip.
  final bool? secondaryTheme;

  /// Custom theme data for the chip. Allows for further customization beyond the default styling.
  final ChipThemeData? chipThemeData;

  /// An optional avatar widget to display at the beginning of the chip.
  final Widget? avatar;

  /// The main content of the chip. Typically a text label.
  final Widget label;

  /// An optional delete icon to display at the end of the chip. Tapping this icon triggers the [onDeleted] callback.
  final Widget? deleteIcon;

  /// Callback function that is called when the delete icon is tapped.
  final VoidCallback? onDeleted;

  /// Tooltip message for the delete button. Provides additional context to the user.
  final String? deleteButtonTooltipMessage;

  /// Controls how the chip should clip its content.
  final Clip clipBehavior;

  /// Focus node for managing focus on the chip.
  final FocusNode? focusNode;

  /// Whether the chip should autofocus when it gains focus.
  final bool autofocus;

  /// Adjusts the density of the visual layout for the chip.
  final VisualDensity? visualDensity;

  /// Configures the minimum size of the tap target.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Constructs a [ChipCustom] widget.
  const ChipCustom({
    super.key,
    this.secondaryTheme,
    this.chipThemeData,
    this.avatar,
    required this.label,
    this.deleteIcon,
    this.onDeleted,
    this.deleteButtonTooltipMessage,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.visualDensity,
    this.materialTapTargetSize,
  });

  @override
  Widget build(BuildContext context) {
    // Ensures that the Material design is applied to the context of this widget.
    assert(debugCheckHasMaterial(context));

    // Determines the default theme for the chip based on the context and whether a secondary theme is applied.
    final ChipThemeData defaultTheme = _ChipDefaults(
      context: context,
      secondaryTheme: secondaryTheme ?? false,
    );

    // Resolves the delete icon based on the provided icon or the default Material 3 design.
    final Widget? resolvedDeleteIcon = deleteIcon ??
        (Theme.of(context).useMaterial3
            ? const Icon(Icons.clear, size: 18)
            : null);

    // Returns the RawChip widget configured with the provided and resolved properties.
    return RawChip(
      defaultProperties: defaultTheme,
      avatar: avatar,
      label: label,
      labelStyle: chipThemeData?.labelStyle,
      labelPadding: chipThemeData?.labelPadding,
      deleteIcon: resolvedDeleteIcon,
      onDeleted: onDeleted,
      deleteIconColor: chipThemeData?.deleteIconColor,
      deleteButtonTooltipMessage: deleteButtonTooltipMessage,
      side: chipThemeData?.side,
      shape: chipThemeData?.shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      color: chipThemeData?.color,
      backgroundColor: chipThemeData?.backgroundColor,
      padding: chipThemeData?.padding,
      visualDensity: visualDensity,
      materialTapTargetSize: materialTapTargetSize,
      elevation: chipThemeData?.elevation,
      shadowColor: chipThemeData?.shadowColor,
      surfaceTintColor: chipThemeData?.surfaceTintColor,
      iconTheme: chipThemeData?.iconTheme,
      avatarBoxConstraints: chipThemeData?.avatarBoxConstraints,
      deleteIconBoxConstraints: chipThemeData?.deleteIconBoxConstraints,
    );
  }
}

/// Provides default theme data for [ChipCustom] based on the Material design guidelines.
class _ChipDefaults extends ChipThemeData {
  _ChipDefaults({required this.context, this.secondaryTheme = false})
      : super(
          elevation: 0.0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          showCheckmark: false,
        );

  final BuildContext context;
  final bool secondaryTheme;
  late final ColorScheme _colors = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  @override
  TextStyle? get labelStyle => _textTheme.labelLarge?.copyWith(
        color:
            secondaryTheme ? _colors.onSecondaryContainer : _colors.onSurface,
      );

  @override
  WidgetStateProperty<Color?>? get color =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        return secondaryTheme ? _colors.secondaryContainer : Colors.transparent;
      });

  @override
  Color? get backgroundColor =>
      secondaryTheme ? _colors.secondaryContainer : Colors.transparent;

  @override
  Color? get shadowColor => Colors.transparent;

  @override
  Color? get surfaceTintColor => Colors.transparent;

  @override
  Color? get deleteIconColor =>
      secondaryTheme ? _colors.onSecondaryContainer : _colors.onSurfaceVariant;

  @override
  BorderSide? get side => !secondaryTheme
      ? BorderSide(color: _colors.outline)
      : const BorderSide(color: Colors.transparent);

  @override
  IconThemeData? get iconTheme => IconThemeData(
        color: secondaryTheme ? _colors.primary : _colors.onSurfaceVariant,
        size: 18.0,
      );

  @override
  EdgeInsetsGeometry? get padding => const EdgeInsets.all(8.0);

  /// The label padding of the chip scales with the font size specified in the
  /// [labelStyle], and the system font size settings that scale font sizes
  /// globally.
  ///
  /// The chip at effective font size 14.0 starts with 8px on each side and as
  /// the font size scales up to closer to 28.0, the label padding is linearly
  /// interpolated from 8px to 4px. Once the label has a font size of 2 or
  /// higher, label padding remains 4px.
  @override
  EdgeInsetsGeometry? get labelPadding {
    final double fontSize = labelStyle?.fontSize ?? 14.0;
    final double fontSizeRatio =
        MediaQuery.textScalerOf(context).scale(fontSize) / 14.0;
    return EdgeInsets.lerp(
      const EdgeInsets.symmetric(horizontal: 8.0),
      const EdgeInsets.symmetric(horizontal: 4.0),
      clampDouble(fontSizeRatio - 1.0, 0.0, 1.0),
    )!;
  }
}
