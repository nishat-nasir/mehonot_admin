import 'package:mehonot_admin/presentation/template/template.dart';

ButtonStyle mainTypeButtonTheme({
  double height = 54,
  double width = double.infinity,
  Color? buttonColor,
  TextStyle? textStyle,
  bool? showBorder = false,
}) {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (Set<MaterialState> states) {
      return textStyle ?? ThemeTextSemiBold.k34;
    }),
    foregroundColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      return ThemeColors.white;
    }),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return buttonColor ?? MehonotColorsCommon.buttonColor;
      },
    ),
    maximumSize: MaterialStateProperty.all(Size(width.w, height.h)),
    minimumSize: MaterialStateProperty.all(Size(width.w, height.h)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.r)),
          side: showBorder!
              ? const BorderSide(color: ThemeColors.white)
              : BorderSide.none),
    ),
  );
}

ButtonStyle PrsmSecondaryButtonTheme(
    {bool isCircle = false,
    bool onlyIcon = false,
    double height = 50,
    double elevation = 0.0,
    double width = double.infinity,
    TextStyle? textStyle,
    Color btnBgColor = ThemeColors.white}) {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (Set<MaterialState> states) {
      return textStyle ?? ThemeTextSemiBold.k34;
    }),
    foregroundColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      return ThemeColors.white;
    }),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return MehonotColorsCommon.buttonColor;
      },
    ),
    maximumSize: MaterialStateProperty.all(Size(width.w, height.h)),
    minimumSize: MaterialStateProperty.all(Size(width.w, height.h)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.r)),
          side: BorderSide.none),
    ),
  );
}

ButtonStyle ghostTypeButtonTheme({
  double height = 50,
  double width = double.infinity,
  TextStyle? textStyle,
  required BuildContext context,
}) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;

  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    foregroundColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      return isDark ? ThemeColors.gray300 : ThemeColors.coolgray600;
    }),
    textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (Set<MaterialState> states) {
      return textStyle ?? ThemeTextSemiBold.k34;
    }),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return ThemeColors.transparent;
      },
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return ThemeColors.gray500.withOpacity(0.2);
      },
    ),
    maximumSize: MaterialStateProperty.all(Size(width.w, height.h)),
    minimumSize: MaterialStateProperty.all(Size(width.w, height.h)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        side: BorderSide(width: 1.w, color: ThemeColors.coolgray300),
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
    ),
  );
}

ButtonStyle disabledTypeButtonTheme(
    {double height = 50,
    double width = double.infinity,
    TextStyle? textStyle}) {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    foregroundColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      return ThemeColors.coolgray400;
    }),
    textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (Set<MaterialState> states) {
      return textStyle ?? ThemeTextSemiBold.k34;
    }),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return ThemeColors.bluegray600;
      },
    ),
    enableFeedback: false,
    maximumSize: MaterialStateProperty.all(Size(width.w, height.h)),
    minimumSize: MaterialStateProperty.all(Size(width.w, height.h)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.r),
        ),
      ),
    ),
  );
}

ButtonStyle linkTypeButtonTheme({
  double height = 50,
  double width = double.infinity,
  TextStyle? textStyle,
  Color textColor = ThemeColors.coolgray600,
}) {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    foregroundColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      return textColor;
    }),
    overlayColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return ThemeColors.gray300.withOpacity(0.2);
      },
    ),
    textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (Set<MaterialState> states) {
      return textStyle ?? ThemeTextSemiBold.k34;
    }),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return ThemeColors.transparent;
      },
    ),
    maximumSize: MaterialStateProperty.all(Size(width.w, height.h)),
    minimumSize: MaterialStateProperty.all(Size(width.w, height.h)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
    ),
  );
}



ButtonStyle sidebarTabButtonTheme(bool isActive) {
  return ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      backgroundColor: MaterialStateProperty.all(
          isActive ? ThemeColors.coolgray100 : ThemeColors.white),
      overlayColor: MaterialStateProperty.all(ThemeColors.blue50));
}