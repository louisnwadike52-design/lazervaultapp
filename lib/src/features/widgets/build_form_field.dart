import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';

class BuildFormField extends StatefulWidget {
  const BuildFormField({
    super.key,
    required this.name,
    required this.placeholder,
    this.labelText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.disabled = false,
    this.onTap,
    this.controller,
    this.leading,
    this.textInputType,
    this.inputDecoration,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.validator,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.showCursor,
    this.cursorColor,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.enabled,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.restorationId,
    this.enableIMEPersonalizedLearning = true,
    this.initialValue,
    this.hintStyle,
  });

  final String name;
  final String placeholder;
  final String? labelText;
  final String? helperText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final double? width;
  final bool disabled;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final Widget? leading;
  final TextInputType? textInputType;
  final InputDecoration? inputDecoration;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final FormFieldValidator<String>? validator;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool? showCursor;
  final Color? cursorColor;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final bool? enabled;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final String? restorationId;
  final bool enableIMEPersonalizedLearning;
  final String? initialValue;
  final TextStyle? hintStyle;

  @override
  State<BuildFormField> createState() => BuildFormFieldState();
}

class BuildFormFieldState extends State<BuildFormField> {
  late TextEditingController _controller;
  bool _isPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue ?? '');
    _isPasswordObscured = widget.obscureText;

    if (widget.onChanged != null && widget.controller == null) {
      _controller.addListener(() {
        widget.onChanged!(_controller.text);
      });
    }
  }

  @override
  void didUpdateWidget(covariant BuildFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != null && widget.controller != _controller) {
      if (oldWidget.controller == null) {
        _controller.removeListener(_handleControllerChange);
        _controller.dispose();
      }
      _controller = widget.controller!;
    } else if (widget.controller == null && oldWidget.controller != null) {
      _controller = TextEditingController(text: oldWidget.controller!.text);
      if (widget.onChanged != null) {
        _controller.addListener(_handleControllerChange);
      }
    } else if (widget.controller == null && widget.initialValue != oldWidget.initialValue && widget.initialValue != _controller.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && widget.initialValue != _controller.text) {
          _controller.text = widget.initialValue ?? '';
          _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
        }
      });
    }

    if (widget.obscureText != oldWidget.obscureText) {
      _isPasswordObscured = widget.obscureText;
    }

    if (widget.onChanged != oldWidget.onChanged && widget.controller == null) {
      _controller.removeListener(_handleControllerChange);
      if (widget.onChanged != null) {
        _controller.addListener(_handleControllerChange);
      }
    }
  }

  void _handleControllerChange() {
    if (widget.onChanged != null) {
      widget.onChanged!(_controller.text);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null)
            Text(
              widget.labelText ?? "",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: HybridHexColor.fromHex("#262626"),
              ),
            ),
          SizedBox(height: 8.0.h),
          GestureDetector(
            onTap: widget.disabled ? widget.onTap : null,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.leading != null)
                  Container(
                    height: 48.0.h,
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0.r),
                        bottomLeft: Radius.circular(24.0.r),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: widget.leading!,
                  ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: widget.leading != null
                          ? BorderRadius.only(
                              topRight: Radius.circular(24.0.r),
                              bottomRight: Radius.circular(24.0.r),
                            )
                          : BorderRadius.circular(24.0.r),
                    ),
                    child: AbsorbPointer(
                      absorbing: widget.disabled,
                      child: TextField(
                        controller: _controller,
                        enabled: widget.enabled ?? !widget.disabled,
                        decoration: widget.inputDecoration ??
                            InputDecoration(
                              hintText: widget.placeholder,
                              helperText: widget.helperText,
                              helperStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                              hintStyle: widget.hintStyle ?? TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey.shade600,
                              ),
                              fillColor: Colors.transparent,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: widget.leading != null
                                    ? BorderRadius.only(
                                        topRight: Radius.circular(24.0.r),
                                        bottomRight: Radius.circular(24.0.r),
                                      )
                                    : BorderRadius.circular(24.0.r),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.0.w,
                                vertical: 12.0.h,
                              ),
                              prefixIcon: widget.prefixIcon,
                              suffixIcon: widget.obscureText
                                  ? IconButton(
                                      icon: Icon(
                                        _isPasswordObscured
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordObscured = !_isPasswordObscured;
                                        });
                                      },
                                    )
                                  : widget.suffixIcon,
                            ),
                        keyboardType:
                            widget.keyboardType ?? widget.textInputType,
                        obscureText: _isPasswordObscured,
                        maxLines: widget.maxLines,
                        minLines: widget.minLines,
                        maxLength: widget.maxLength,
                        onChanged: widget.onChanged,
                        onSubmitted: widget.onSubmitted,
                        onEditingComplete: widget.onEditingComplete,
                        autofocus: widget.autofocus,
                        autocorrect: widget.autocorrect,
                        enableSuggestions: widget.enableSuggestions,
                        readOnly: widget.readOnly,
                        textCapitalization: widget.textCapitalization,
                        textInputAction: widget.textInputAction,
                        style: widget.style,
                        strutStyle: widget.strutStyle,
                        textAlign: widget.textAlign,
                        textAlignVertical: widget.textAlignVertical,
                        textDirection: widget.textDirection,
                        showCursor: widget.showCursor,
                        cursorColor: widget.cursorColor,
                        cursorWidth: widget.cursorWidth,
                        cursorHeight: widget.cursorHeight,
                        cursorRadius: widget.cursorRadius,
                        scrollPadding: widget.scrollPadding,
                        enableInteractiveSelection:
                            widget.enableInteractiveSelection,
                        selectionControls: widget.selectionControls,
                        buildCounter: widget.buildCounter,
                        scrollPhysics: widget.scrollPhysics,
                        autofillHints: widget.autofillHints,
                        restorationId: widget.restorationId,
                        enableIMEPersonalizedLearning:
                            widget.enableIMEPersonalizedLearning,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
