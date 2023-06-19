import 'package:flutter/services.dart';
import '../../template/template.dart';

class PrsmInputField extends StatefulWidget {
  final Color? defaultBorderColor;
  final HeroIcons? rightIcon;
  final HeroIcons? leftIcon;
  String? hintText;
  final TextEditingController? controller;
  double? width;
  double? height;
  final bool isRequired;
  final VoidCallback? onTap;
  final bool enabled;
  final bool disableAll;
  final bool isPassword;
  final TextInputType keyboardType;
  final int maxLines;
  final TextStyle? errorSize;
  final AutovalidateMode? autoValidateMode;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChange;
  final Color? fillColor;
  final bool? enableShadow;
  final List<TextInputFormatter>? formatter;
  final void Function(String)? onFieldSubmitted;

  PrsmInputField({
    Key? key,
    this.defaultBorderColor,
    this.validator,
    this.maxLines = 1,
    this.enabled = true,
    this.disableAll = false,
    this.controller,
    this.rightIcon,
    this.leftIcon,
    this.isRequired = false,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.height,
    this.onTap,
    this.width,
    this.errorSize,
    this.autoValidateMode,
    this.onChange,
    this.hintText,
    this.fillColor,
    this.enableShadow = true,
    this.formatter,
    this.onFieldSubmitted,
  }) : super(key: key) {
    hintText ??= 'Enter your text';
    width ??= 300;
    height ??= 44;
  }

  @override
  State<PrsmInputField> createState() => _PrsmInputFieldState();
}

class _PrsmInputFieldState extends State<PrsmInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    Color fillColor = isDark ? PrsmColorsDark.formFillColor : ThemeColors.white;

    Color borderColor =
        isDark ? PrsmColorsDark.formContainerBgColor : ThemeColors.white;
    Color textColor = isDark ? ThemeColors.gray100 : ThemeColors.gray400;

    BorderRadius borderRadius = BorderRadius.circular(18.r);

    return PhysicalModel(
      color: Colors.transparent,
      shadowColor: ThemeColors.black.withOpacity(0.07),
      child: Container(
        decoration: !isDark
            ? widget.enableShadow!
                ? BoxDecoration(
                    border:
                        Border.all(width: 1, color: ThemeColors.coolgray100),
                    boxShadow: ThemeShadows.shadowSm,
                    borderRadius: borderRadius,
                  )
                : null
            : null,
        child: TextFormField(
          autovalidateMode: widget.autoValidateMode,
          validator: widget.validator,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChange,
          obscureText: widget.isPassword ? _obscureText : false,
          onTap: widget.onTap,
          inputFormatters: widget.formatter,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          mouseCursor: widget.disableAll
              ? SystemMouseCursors.forbidden
              : SystemMouseCursors.text,
          controller: widget.controller,
          readOnly: widget.disableAll || !widget.enabled,
          style: widget.disableAll
              ? ThemeTextRegular.k14.copyWith(color: ThemeColors.gray700)
              : ThemeTextRegular.k14.copyWith(
                  color: isDark
                      ? PrsmColorsDark.textColor
                      : PrsmColorsLight.textColor),
          decoration: InputDecoration(
            errorMaxLines: 2,
            fillColor: widget.fillColor ?? fillColor,
            filled: widget.disableAll ? false : true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
            enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                    width: 0, color: widget.defaultBorderColor ?? borderColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(width: 2.w, color: ThemeColors.red600)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: BorderSide(width: 4.w, color: ThemeColors.red500)),
            focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                    width: 2.w,
                    color: widget.disableAll
                        ? ThemeColors.gray800
                        : isDark
                            ? ThemeColors.coolgray500
                            : ThemeColors.coolgray300)),
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r)),
            suffixIcon: _getRightIcon(),
            prefixIcon: _getLeftIcon(),
            prefixIconConstraints: BoxConstraints(minWidth: 30.w),
            suffixIconConstraints: BoxConstraints(minWidth: 30.w),
            suffixIconColor: ThemeColors.coolgray700,
            prefixIconColor: ThemeColors.coolgray700,
            errorStyle: widget.errorSize ??
                ThemeTextRegular.k10.copyWith(
                  color: ThemeColors.red600,
                  fontWeight: FontWeight.w400,
                ),
            hintText: widget.hintText,
            hintStyle: ThemeTextRegular.k14.copyWith(
              color: textColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget? _getRightIcon() {
    if (widget.isPassword) {
      return IconButton(
          padding: EdgeInsets.zero,
          icon: HeroIcon(
            !_obscureText ? HeroIcons.eye : HeroIcons.lockClosed,
            color: ThemeColors.gray700,
            size: 44.w,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          });
    }
    if (widget.rightIcon != null) {
      return Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: HeroIcon(widget.rightIcon!,
              color: ThemeColors.gray700, size: 44.w));
    }
    return null;
  }

  Widget? _getLeftIcon() {
    if (widget.leftIcon != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: HeroIcon(
          widget.leftIcon!,
          color: ThemeColors.gray700,
          size: 44.w,
        ),
      );
    }
    return null;
  }
}
