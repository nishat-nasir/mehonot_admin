import 'package:mehonot_admin/presentation/template/template.dart';
import 'dart:math';

import '../../template/theme/theme_button.dart';

class PrimaryButton extends StatelessWidget {
  ButtonType buttonType;
  ButtonSize buttonSize;
  HeroIcons? icon;
  String buttonText;
  bool isLoading;
  VoidCallback onPressed;
  Color? linkTypeBtnColor;
  TextStyle? btnTextStyle;
  Color? bgColor;

  PrimaryButton({
    super.key,
    this.buttonType = ButtonType.Main,
    this.buttonSize = ButtonSize.L,
    this.icon,
    this.isLoading = false,
    required this.buttonText,
    required this.onPressed,
    this.linkTypeBtnColor,
    this.btnTextStyle,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: _getButtonTheme(context),
        onPressed: _getOnPressed(),
        child: _getChild());
  }

  VoidCallback? _getOnPressed() {
    if (isLoading) {
      return null;
    }
    if (buttonType == ButtonType.Disabled) {
      return null;
    }
    return onPressed;
  }

  Widget _getChild() {
    if (isLoading) {
      return LoadingWidget(
          iconColor: ThemeColors.white,
          iconSize: buttonSize == ButtonSize.S ? 36 : 56);
    }
    if (icon != null) {
      return SpacedRow(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          horizontalSpace: 8,
          children: [
            HeroIcon(icon!,
                size: buttonSize == ButtonSize.S ? 36.h : 56.h,
                color: linkTypeBtnColor),
            SizedText(
              text: buttonText,
            )
          ]);
    }
    return SizedText(
      softWrap: false,
      text: buttonText,
      textStyle: btnTextStyle ?? ThemeTextSemiBold.k18,
    );
  }

  _getButtonTheme(BuildContext context) {
    switch (buttonType) {
      case ButtonType.Main:
        return mainTypeButtonTheme(
            height: _getButtonSize().height,
            width: _getButtonSize().width,
            buttonColor: bgColor,
            textStyle: _getTextStyle());
      case ButtonType.Ghost:
        return ghostTypeButtonTheme(
            height: _getButtonSize().height,
            width: _getButtonSize().width,
            context: context,
            textStyle: _getTextStyle());
      case ButtonType.Disabled:
        return disabledTypeButtonTheme(
            height: _getButtonSize().height,
            width: _getButtonSize().width,
            textStyle: _getTextStyle());
      case ButtonType.Secondary:
        return PrsmSecondaryButtonTheme(
            height: _getButtonSize().height,
            width: _getButtonSize().width,
            textStyle: _getTextStyle());
      case ButtonType.Link:
        bool isDark = Theme.of(context).brightness == Brightness.dark;
        return linkTypeButtonTheme(
            textColor: linkTypeBtnColor ??
                (isDark ? ThemeColors.coolgray200 : ThemeColors.coolgray700),
            height: _getButtonSize().height,
            width: _getButtonSize().width,
            textStyle: _getTextStyle());
    }
  }

  Size _getButtonSize() {
    Size size = const Size(double.infinity, 118);
    switch (buttonSize) {
      case ButtonSize.S2:
        size = const Size(164, 52);
        break;
      case ButtonSize.XS:
        size = const Size(152, 52);
        break;
      case ButtonSize.M:
        size = const Size(486, 104);
        break;
      case ButtonSize.S:
        size = const Size(199, 66);
        break;
      case ButtonSize.L2:
        size = const Size(576, 104);
        break;
      case ButtonSize.S3:
        size = const Size(250, 66);
        break;
      case ButtonSize.L3:
        size = const Size(748, 104);
        break;
      case ButtonSize.L:
        break;
    }

    return size;
  }

  TextStyle _getTextStyle() {
    TextStyle textStyle =
        ThemeTextSemiBold.k34.copyWith(color: linkTypeBtnColor);
    switch (buttonSize) {
      case ButtonSize.S2:
        textStyle = ThemeTextSemiBold.k24.copyWith(color: linkTypeBtnColor);
        break;
      case ButtonSize.XS:
        textStyle = ThemeTextRegular.k28.copyWith(color: linkTypeBtnColor);
        break;
      case ButtonSize.M:
      case ButtonSize.L2:
        textStyle = ThemeTextSemiBold.k30.copyWith(color: linkTypeBtnColor);
        break;
      case ButtonSize.S:
        textStyle = ThemeTextSemiBold.k28.copyWith(color: linkTypeBtnColor);
        break;
      case ButtonSize.S3:
        textStyle = ThemeTextSemiBold.k28.copyWith(color: linkTypeBtnColor);
        break;
      case ButtonSize.L3:
        textStyle = ThemeTextSemiBold.k30.copyWith(color: linkTypeBtnColor);
        break;
      case ButtonSize.L:
        break;
    }

    return textStyle;
  }
}

enum ButtonType {
  Main,
  Ghost,
  Disabled,
  Link,
  Secondary,
}

enum ButtonSize { L, M, S, XS, L2, S2, S3, L3 }

class LoadingWidget extends StatefulWidget {
  Color iconColor;
  double iconSize;

  LoadingWidget({this.iconColor = ThemeColors.white, this.iconSize = 56});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.rotate(
        angle: _controller.value * 2 * pi,
        child: child,
      ),
      child: SvgPicture.asset('assets/images/svg/loading_outline.svg',
          height: widget.iconSize.h, color: widget.iconColor),
    );
  }
}
