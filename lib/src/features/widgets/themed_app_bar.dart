import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// An app bar that lives in the Scaffold's BODY rather than its `appBar:` slot.
///
/// WHY THAT MATTERS FOR THE STATUS BAR
///
/// A real [AppBar] publishes a [SystemUiOverlayStyle], which is what tells the
/// OS whether to paint the clock and battery icons dark or light. This widget
/// is a plain Container in the body, so it published nothing — and the status
/// bar simply kept whatever the PREVIOUS screen had set. On Settings, whose
/// background is a near-white 0xFFF9FAFB, arriving from a dark screen left
/// white-on-white: the clock and battery were invisible.
///
/// It already reserves [MediaQuery.padding.top] so the content clears the
/// status bar; the only thing missing was saying what colour the icons should
/// be. That is now derived from the background actually behind them, so every
/// screen using this bar is fixed at once and a future screen cannot forget.
class ThemedAppBar extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color backgroundColor;
  final double elevation;
  final Color titleColor;
  final double? topPadding;
  final double? appBarHeight;

  /// Override the icon brightness when the derived value is wrong — e.g. a bar
  /// painted over a dark hero image on an otherwise light screen.
  final SystemUiOverlayStyle? systemOverlayStyle;

  const ThemedAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0.0,
    this.titleColor = Colors.black,
    this.topPadding,
    this.appBarHeight,
    this.systemOverlayStyle,
  });

  /// The colour actually behind the status bar.
  ///
  /// [backgroundColor] defaults to transparent — the common case — and a
  /// transparent bar shows the Scaffold beneath it, so that is what the icons
  /// have to contrast against. Reading the declared colour instead would get
  /// every default-constructed bar in the app wrong.
  Color _effectiveBackground(BuildContext context) {
    if (backgroundColor.a > 0.05) return backgroundColor;
    return Theme.of(context).scaffoldBackgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    final double paddingTop = topPadding ?? MediaQuery.of(context).padding.top;
    final bg = _effectiveBackground(context);
    // A light background needs DARK icons, and vice versa. Both platform fields
    // are set because iOS reads statusBarBrightness and Android reads
    // statusBarIconBrightness — setting only one fixes one platform and leaves
    // the other exactly as broken.
    final isLightBg =
        ThemeData.estimateBrightnessForColor(bg) == Brightness.light;
    final overlay = systemOverlayStyle ??
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              isLightBg ? Brightness.dark : Brightness.light,
          statusBarBrightness: isLightBg ? Brightness.light : Brightness.dark,
        );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlay,
      child: Material(
        elevation: elevation,
        color: backgroundColor,
        child: Container(
          padding: EdgeInsets.only(
            top: paddingTop,
          ),
          height: appBarHeight ?? kToolbarHeight + paddingTop,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Leading widget, typically an icon button
              leading ?? const SizedBox(width: 48),
              // Title centred in the available space
              Expanded(
                child: Text(
                  title != null ? title! : '',
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Actions on the right side, if any; otherwise, a placeholder for spacing
              if (actions != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions!,
                )
              else
                const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }
}
