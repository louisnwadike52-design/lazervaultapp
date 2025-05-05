import 'package:flutter/material.dart';

class ThemedAppBar extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color backgroundColor;
  final double elevation;
  final Color titleColor;
  final double? topPadding;
  final double? appBarHeight;
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
  });

  @override
  Widget build(BuildContext context) {
    final double paddingTop = topPadding ?? MediaQuery.of(context).padding.top;
    return Material(
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
    );
  }
}
