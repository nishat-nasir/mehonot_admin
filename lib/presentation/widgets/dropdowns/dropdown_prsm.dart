import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mehonot_admin/presentation/template/template.dart';

class PrsmDropdown extends StatefulWidget {
  List listValues;
  dynamic value;
  final ValueChanged onChanged;
  final DropdownSize dropdownSize;
  final String? hint;
  final bool addDivider;
  final VoidCallback? onLastItemExistFunction;
  final String? onLastItemExistMsg;
  final double borderRadius;
  final double buttonHorizontalPadding;
  final double buttonVerticalPadding;
  final bool disabled;
  final double? width;
  final bool? enableBorder;
  final bool? enableShadow;
  final Color? bgColor;

  PrsmDropdown({
    Key? key,
    required this.listValues,
    required this.onChanged,
    this.value,
    this.onLastItemExistFunction,
    this.dropdownSize = DropdownSize.SIZE1,
    this.hint,
    this.addDivider = false,
    this.onLastItemExistMsg,
    this.borderRadius = 18,
    this.width,
    this.buttonHorizontalPadding = 24,
    this.buttonVerticalPadding = 14,
    this.disabled = false,
    this.enableBorder = false,
    this.enableShadow = true,
    this.bgColor,
  }) : super(key: key);

  @override
  State<PrsmDropdown> createState() => _PrsmDropdownState();
}

class _PrsmDropdownState extends State<PrsmDropdown> {
  bool activeDropDown = true;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode(debugLabel: 'Button');
    focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (focusNode.hasFocus != activeDropDown) {
      setState(() {
        activeDropDown = focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    Color fillColor = widget.bgColor ??
        (isDark ? PrsmColorsDark.formFillColor : ThemeColors.white);
    Color borderColor =
    isDark ? ThemeColors.coolgray500 : ThemeColors.coolgray200;
    Color textColor = isDark ? ThemeColors.gray100 : ThemeColors.gray800;
    logger(widget.bgColor);
    return DropdownButtonHideUnderline(
      child: Container(
        decoration: BoxDecoration(
          color: fillColor,
          border: _borderController(borderColor),
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          boxShadow: widget.enableShadow! ? _shadowController() : null,
        ),
        child: IgnorePointer(
          ignoring: widget.disabled,
          child: DropdownButton2(
              focusNode: focusNode,
              isExpanded: true,
              hint: SizedText(
                  text: widget.hint ?? "select",
                  textStyle: _textSizeController(textColor)),
              icon: RotatedBox(
                quarterTurns: !activeDropDown ? 2 : 0,
                child: HeroIcon(
                  HeroIcons.chevronDown,
                  style: HeroIconStyle.solid,
                  color: _colorController(textColor),
                  size: widget.dropdownSize == DropdownSize.SIZE1
                      ? 42.h
                      : widget.dropdownSize == DropdownSize.SIZE5
                      ? 43.h
                      : 32.h,
                ),
              ),
              items: _addDividersAfterItems(textColor),
              value: widget.value,
              onChanged: widget.onChanged,
              buttonHeight: _buttonHeightController(),
              buttonWidth: _buttonWidthController(),
              itemHeight: 70.h,
              dropdownWidth: _dropDownWidthController(),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
              ),
              buttonPadding: EdgeInsets.symmetric(
                  vertical: widget.buttonVerticalPadding.h,
                  horizontal: widget.buttonHorizontalPadding.w),
              dropdownPadding:
              EdgeInsets.symmetric(horizontal: 0.w, vertical: 14.h),
              dropdownElevation: 2),
        ),
      ),
    );
  }

  // disabling & icon & text color
  _colorController(Color textColorContext) {
    if (widget.disabled) {
      return ThemeColors.coolgray400;
    } else {
      return textColorContext;
    }
  }

  _borderController(Color borderColorContext) {
    if (widget.dropdownSize == DropdownSize.SIZE4) {
      return widget.enableBorder ??
          Border.all(width: 2.w, color: borderColorContext);
    } else if (widget.dropdownSize != DropdownSize.SIZE1) {
      return widget.enableBorder ??
          Border.all(width: 1.w, color: borderColorContext);
    } else {
      return widget.enableBorder!
          ? Border.all(width: 1.w, color: borderColorContext)
          : null;
    }
  }

  _buttonWidthController() {
    switch (widget.dropdownSize) {
      case DropdownSize.SIZE1:
        return 675.w;
      case DropdownSize.SIZE2:
        return 240.w;
      case DropdownSize.SIZE3:
        return 240.w;
      case DropdownSize.SIZE4:
        return 116.w;
      case DropdownSize.SIZE5:
        return 576.w;
    }
  }

  _buttonHeightController() {
    switch (widget.dropdownSize) {
      case DropdownSize.SIZE1:
        return 115.h;
      case DropdownSize.SIZE2:
        return 64.h;
      case DropdownSize.SIZE3:
        return 64.h;
      case DropdownSize.SIZE4:
        return 54.h;
      case DropdownSize.SIZE5:
        return 84.h;
    }
  }

  // _radiusController() {
  //   if (widget.dropdownSize == DropdownSize.SIZE4) {
  //     return BorderRadius.circular(12.r);
  //   } else {
  //     return BorderRadius.circular(24.r);
  //   }
  // }

  _shadowController() {
    if (widget.dropdownSize == DropdownSize.SIZE1) {
      return ThemeShadows.shadowSm;
    } else {
      return null;
    }
  }

  _textSizeController(Color textColorContext) {
    if (widget.dropdownSize == DropdownSize.SIZE1) {
      return ThemeTextRegular.k14
          .copyWith(color: _colorController(textColorContext));
    }
    if (widget.dropdownSize == DropdownSize.SIZE4) {
      return ThemeTextRegular.k18
          .copyWith(color: _colorController(textColorContext));
    } else {
      return ThemeTextRegular.k13
          .copyWith(color: _colorController(textColorContext));
    }
  }

  _dropDownWidthController() {
    if (widget.dropdownSize != DropdownSize.SIZE1) {
      return 400.w;
    } else {
      return null;
    }
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(
      Color textColorContext) {
    List listValues = widget.listValues;
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in listValues) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item.toString(),
            child: SizedText(
              text: item.toString(),
              textStyle: ThemeTextRegular.k14.copyWith(color: textColorContext),
            ),
          ),
          if (widget.addDivider)
            if (item != listValues.last)
              DropdownMenuItem<String>(
                enabled: false,
                child: Divider(
                  height: .5.h,
                ),
              ),
        ],
      );
    }
    if (widget.onLastItemExistFunction != null) {
      _menuItems.add(
        DropdownMenuItem<String>(
          enabled: false,
          child: Divider(
            height: .5.h,
          ),
        ),
      );
      _menuItems.add(
        DropdownMenuItem<String>(
          value: widget.onLastItemExistMsg!,
          enabled: false,
          child: SpacedRow(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            horizontalSpace: 14,
            children: [
              HeroIcon(
                HeroIcons.plusCircle,
                size: 40.w,
                color: ThemeColors.coolgray600,
              ),
              GestureDetector(
                onTap: widget.onLastItemExistFunction,
                child: SizedText(
                    text: 'Добавить поставщика',
                    textStyle: ThemeTextRegular.k26
                        .copyWith(color: ThemeColors.coolgray600)),
              ),
            ],
          ),
        ),
      );
    }
    return _menuItems;
  }
}

/// SIZE is not clear in the design

enum DropdownSize { SIZE1, SIZE2, SIZE3, SIZE4, SIZE5 }
