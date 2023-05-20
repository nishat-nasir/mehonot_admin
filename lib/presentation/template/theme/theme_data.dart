// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mehonot_admin/presentation/template/base/template.dart';
// import 'package:mehonot_admin/presentation/template/base/theme_color.dart';
//
// import '../base/theme_size_style.dart';
//
// class MainTheme {}
//
// ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: PorisromColorsLight.primaryColor,
//     floatingActionButtonTheme: const FloatingActionButtonThemeData(
//         backgroundColor: ThemeColors.gray50),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ButtonStyle(
//             padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                 const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
//             shape: MaterialStateProperty.all<OutlinedBorder>(
//                 RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0))),
//             backgroundColor:
//                 MaterialStateProperty.all<Color>(ThemeColors.gray50))),
//     inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20.0),
//             borderSide: BorderSide.none),
//         filled: true,
//         fillColor: Colors.grey.withOpacity(0.1)));
//
// ThemeData darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   switchTheme: SwitchThemeData(
//     trackColor: MaterialStateProperty.all<Color>(Colors.grey),
//     thumbColor: MaterialStateProperty.all<Color>(Colors.white),
//   ),
//   inputDecorationTheme: InputDecorationTheme(
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20.0),
//           borderSide: BorderSide.none),
//       filled: true,
//       fillColor: Colors.grey.withOpacity(0.1)),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ButtonStyle(
//           padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//               const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
//           shape: MaterialStateProperty.all<OutlinedBorder>(
//               RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0))),
//           backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
//           foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
//           overlayColor: MaterialStateProperty.all<Color>(Colors.black26))),
// );
//
// TextButtonThemeData _textButtonTheme() {
//   return TextButtonThemeData(style: ButtonStyle(
//     foregroundColor: MaterialStateProperty.resolveWith<Color>(
//       (Set<MaterialState> states) {
//         if (states.contains(MaterialState.disabled)) return ThemeColors.gray50;
//         return ThemeColors.white;
//       },
//     ),
//   ));
// }
//
// FloatingActionButtonThemeData _fabTheme() {
//   return FloatingActionButtonThemeData(
//     elevation: 0,
//     sizeConstraints: BoxConstraints(minHeight: 124.w, minWidth: 124.w),
//     foregroundColor: ThemeColors.white,
//     backgroundColor: ThemeColors.orange500,
//   );
// }
//
// AppBarTheme _appBarTheme() {
//   return const AppBarTheme(
//       elevation: 0,
//       toolbarHeight: ThemeSizeStyle.appBarHeight,
//       backgroundColor: ThemeColors.white);
// }
//
// ColorScheme _colorScheme() {
//   return ColorScheme.fromSwatch(
//     accentColor: ThemeColors.coolgray100,
//     backgroundColor: ThemeColors.coolgray50,
//     cardColor: ThemeColors.orange50,
//     errorColor: ThemeColors.red200,
//   );
// }
//
// ButtonThemeData _buttonTheme() {
//   return ButtonThemeData(
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
//     highlightColor: ThemeColors.orange400,
//     padding: EdgeInsets.zero,
//   );
// }
//
// CheckboxThemeData _checkboxTheme() {
//   return CheckboxThemeData(
//       visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//       fillColor: MaterialStateProperty.all(ThemeColors.orange500),
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       side: BorderSide(width: 1.w, color: ThemeColors.coolgray300),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(4.r),
//       ));
// }
//
// ProgressIndicatorThemeData _progressIndicatorTheme() {
//   return const ProgressIndicatorThemeData(
//     color: ThemeColors.orange500,
//   );
// }
//
// ButtonStyle mainTypeButtonTheme(
//     {double height = 50,
//     double width = double.infinity,
//     TextStyle textStyle = ThemeTextSemibold.k34}) {
//   return ButtonStyle(
//     elevation: MaterialStateProperty.all(0),
//     padding: MaterialStateProperty.all(EdgeInsets.zero),
//     textStyle: MaterialStateProperty.resolveWith<TextStyle>(
//         (Set<MaterialState> states) {
//       return textStyle;
//     }),
//     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//       (Set<MaterialState> states) {
//         return ThemeColors.orange500;
//       },
//     ),
//     maximumSize: MaterialStateProperty.all(Size(width.w, height.h)),
//     minimumSize: MaterialStateProperty.all(Size(width.w, height.h)),
//     shape: MaterialStateProperty.all(
//       RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(24.r),
//         ),
//       ),
//     ),
//   );
// }
//
// ButtonStyle PrsmSecondaryButtonTheme(
//     {bool isCircle = false,
//     bool onlyIcon = false,
//     double height = 50,
//     double elevation = 0.0,
//     double width = double.infinity,
//     TextStyle textStyle = ThemeTextSemibold.k34,
//     Color btnBgColor = ThemeColors.white}) {
//   return ButtonStyle(
//     elevation: MaterialStateProperty.all(elevation),
//     padding: MaterialStateProperty.all(EdgeInsets.zero),
//     foregroundColor:
//         MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//       if (onlyIcon || isCircle) {
//         return ThemeColors.yellow600;
//       }
//       if (!onlyIcon && !isCircle) {
//         return ThemeColors.black;
//       }
//       return ThemeColors.orange500;
//     }),
//     textStyle: MaterialStateProperty.resolveWith<TextStyle>(
//         (Set<MaterialState> states) {
//       return textStyle;
//     }),
//     backgroundColor:
//         MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//       if (isCircle || onlyIcon) {
//         return ThemeColors.orange500;
//       }
//       return btnBgColor;
//     }),
//     maximumSize: MaterialStateProperty.all(Size(width.w, height.w)),
//     minimumSize: MaterialStateProperty.all(Size(width.w, height.w)),
//     shape: MaterialStateProperty.all(
//       !isCircle
//           ? RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(24.r),
//               ),
//             )
//           : const CircleBorder(),
//     ),
//   );
// }
//
// ButtonStyle sidebarTabButtonTheme(bool isActive) {
//   return ButtonStyle(
//       elevation: MaterialStateProperty.all(0),
//       padding: MaterialStateProperty.all(EdgeInsets.zero),
//       backgroundColor: MaterialStateProperty.all(
//           isActive ? ThemeColors.coolgray100 : ThemeColors.white),
//       overlayColor: MaterialStateProperty.all(ThemeColors.blue50));
// }
//
// ButtonStyle secondaryTypeButtonTheme(
//     {double height = 50,
//     double width = double.infinity,
//     TextStyle textStyle = ThemeTextSemibold.k34}) {
//   return ButtonStyle(
//     elevation: MaterialStateProperty.all(0),
//     padding: MaterialStateProperty.all(EdgeInsets.zero),
//     foregroundColor:
//         MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//       return ThemeColors.orange500;
//     }),
//     textStyle: MaterialStateProperty.resolveWith<TextStyle>(
//         (Set<MaterialState> states) {
//       return textStyle;
//     }),
//     backgroundColor:
//         MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//       return ThemeColors.orange200;
//     }),
//     maximumSize: MaterialStateProperty.all(Size(width.w, height.h)),
//     minimumSize: MaterialStateProperty.all(Size(width.w, height.h)),
//     shape: MaterialStateProperty.all(RoundedRectangleBorder(
//       borderRadius: BorderRadius.all(
//         Radius.circular(24.r),
//       ),
//     )),
//   );
// }
//
// ButtonStyle ghostTypeButtonTheme(
//     {double height = 50,
//     double width = double.infinity,
//     TextStyle textStyle = ThemeTextSemibold.k34}) {
//   return ButtonStyle(
//     elevation: MaterialStateProperty.all(0),
//     padding: MaterialStateProperty.all(EdgeInsets.zero),
//     foregroundColor:
//         MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//       return ThemeColors.coolgray600;
//     }),
//     textStyle: MaterialStateProperty.resolveWith<TextStyle>(
//         (Set<MaterialState> states) {
//       return textStyle;
//     }),
//     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//       (Set<MaterialState> states) {
//         return ThemeColors.transparent;
//       },
//     ),
//     overlayColor: MaterialStateProperty.resolveWith<Color>(
//       (Set<MaterialState> states) {
//         return ThemeColors.gray100.withOpacity(0.2);
//       },
//     ),
//     maximumSize: MaterialStateProperty.all(Size(width.w, height.h)),
//     minimumSize: MaterialStateProperty.all(Size(width.w, height.h)),
//     shape: MaterialStateProperty.all(
//       RoundedRectangleBorder(
//         side: BorderSide(width: 1.w, color: ThemeColors.coolgray300),
//         borderRadius: BorderRadius.all(
//           Radius.circular(24.r),
//         ),
//       ),
//     ),
//   );
// }
//
// ButtonStyle disabledTypeButtonTheme(
//     {double height = 50,
//     double width = double.infinity,
//     TextStyle textStyle = ThemeTextSemibold.k34}) {
//   return ButtonStyle(
//     elevation: MaterialStateProperty.all(0),
//     padding: MaterialStateProperty.all(EdgeInsets.zero),
//     foregroundColor:
//         MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//       return ThemeColors.white.withOpacity(0.5);
//     }),
//     textStyle: MaterialStateProperty.resolveWith<TextStyle>(
//         (Set<MaterialState> states) {
//       return textStyle;
//     }),
//     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//       (Set<MaterialState> states) {
//         return ThemeColors.orangeAdditional;
//       },
//     ),
//     enableFeedback: false,
//     maximumSize: MaterialStateProperty.all(Size(width.w, height.h)),
//     minimumSize: MaterialStateProperty.all(Size(width.w, height.h)),
//     shape: MaterialStateProperty.all(
//       RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(24.r),
//         ),
//       ),
//     ),
//   );
// }
//
// ButtonStyle linkTypeButtonTheme(
//     {double height = 50,
//     double width = double.infinity,
//     TextStyle textStyle = ThemeTextSemibold.k34,
//     Color textColor = ThemeColors.coolgray600}) {
//   return ButtonStyle(
//     elevation: MaterialStateProperty.all(0),
//     padding: MaterialStateProperty.all(EdgeInsets.zero),
//     foregroundColor:
//         MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//       return textColor;
//     }),
//     overlayColor: MaterialStateProperty.resolveWith<Color>(
//       (Set<MaterialState> states) {
//         return ThemeColors.gray300.withOpacity(0.2);
//       },
//     ),
//     textStyle: MaterialStateProperty.resolveWith<TextStyle>(
//         (Set<MaterialState> states) {
//       return textStyle;
//     }),
//     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//       (Set<MaterialState> states) {
//         return ThemeColors.transparent;
//       },
//     ),
//     maximumSize: MaterialStateProperty.all(Size(width.w, height.h)),
//     minimumSize: MaterialStateProperty.all(Size(width.w, height.h)),
//     shape: MaterialStateProperty.all(
//       RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(24.r),
//         ),
//       ),
//     ),
//   );
// }
//
// ButtonStyle saleTypeButtonTheme(
//     {double height = 56,
//     double width = double.infinity,
//     TextStyle textStyle = ThemeTextSemibold.k34,
//     Color textColor = ThemeColors.coolgray600}) {
//   return ButtonStyle(
//     elevation: MaterialStateProperty.all(0),
//     padding: MaterialStateProperty.all(EdgeInsets.zero),
//     foregroundColor:
//         MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//       return textColor;
//     }),
//     overlayColor: MaterialStateProperty.resolveWith<Color>(
//       (Set<MaterialState> states) {
//         return ThemeColors.gray300.withOpacity(0.2);
//       },
//     ),
//     textStyle: MaterialStateProperty.resolveWith<TextStyle>(
//         (Set<MaterialState> states) {
//       return textStyle;
//     }),
//     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//       (Set<MaterialState> states) {
//         return ThemeColors.amber500;
//       },
//     ),
//     maximumSize: MaterialStateProperty.all(Size(width.w, height.h)),
//     minimumSize: MaterialStateProperty.all(Size(width.w, height.h)),
//     shape: MaterialStateProperty.all(
//       RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(24.r),
//         ),
//       ),
//     ),
//   );
// }
