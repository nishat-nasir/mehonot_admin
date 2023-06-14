import '../template/template.dart';
import '../utils/constants.dart';

class LocationBottomSheet extends StatelessWidget {
  String selectedLocation;
  Function(String) onTap;

  LocationBottomSheet({
    Key? key,
    required this.selectedLocation,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Container(
        decoration: BoxDecoration(
            color: isDark
                ? PrsmColorsDark.formContainerBgColor
                : ThemeColors.gray50,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r))),
        child: SpacedColumn(children: [
          SizedBox(height: 18.h),
          Container(
              height: 8.h,
              width: 200.w,
              decoration: BoxDecoration(
                  color: ThemeColors.coolgray400,
                  borderRadius: BorderRadius.circular(8.r))),
          SizedBox(height: 32.h),
          _buildLocationList(isDark,
              locations: Constants.locationsBd().names(),
              selectedLocation: selectedLocation)
        ]));
  }

  Widget _buildLocationList(bool isDark,
      {required String selectedLocation, required List<String> locations}) {
    List<Widget> list = [];
    for (var i = 0; i < locations.length; i++) {
      list.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.w),
          child: _buildLocationBar(
              locationName: locations[i],
              isDark: isDark,
              selectedLocation: selectedLocation)));
    }
    return SpacedColumn(verticalSpace: 24, children: list);
  }

  Widget _buildLocationBar({
    required String locationName,
    required bool isDark,
    required String selectedLocation,
  }) {
    return InkWell(
      onTap: () {
        onTap(locationName);
      },
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
            color: isDark
                ? locationName == selectedLocation
                ? ThemeColors.indigo400
                : PrsmColorsDark.accentColor
                : locationName == selectedLocation
                ? ThemeColors.indigo400
                : ThemeColors.indigo50,
            borderRadius: BorderRadius.circular(8.r)),
        child: Center(
          child: SizedText(
            text: locationName,
            textStyle: ThemeTextSemiBold.k16.copyWith(
                color: isDark
                    ? locationName == selectedLocation
                    ? ThemeColors.coolgray900
                    : ThemeColors.white
                    : locationName == selectedLocation
                    ? ThemeColors.white
                    : ThemeColors.coolgray900),
          ),
        ),
      ),
    );
  }
}
