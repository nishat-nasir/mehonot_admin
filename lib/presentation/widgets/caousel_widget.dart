import 'package:carousel_slider/carousel_slider.dart';

import '../template/template.dart';

class PrsmCarouselWidget extends StatefulWidget {
  final List<String> imageList;
  final double height;
  final bool autoPlay;

  PrsmCarouselWidget({
    Key? key,
    required this.imageList,
    this.height = 320,
    this.autoPlay = false,
  }) : super(key: key);

  @override
  State<PrsmCarouselWidget> createState() => _PrsmCarouselWidgetState();
}

class _PrsmCarouselWidgetState extends State<PrsmCarouselWidget> {
  final CarouselController _carouselCntr = CarouselController();

  late String _currentImg;

  @override
  void initState() {
    super.initState();
    _currentImg = widget.imageList[0];
  }

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      verticalSpace: 22,
      children: [
        CarouselSlider(
          carouselController: _carouselCntr,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                _currentImg = widget.imageList[index];
              });
            },
            height: widget.height.h,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            autoPlay: widget.autoPlay,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            scrollDirection: Axis.horizontal,
          ),
          items: widget.imageList
              .map((e) => ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(e, fit: BoxFit.fitWidth, width: 1000.w)))
              .toList(),
        ),
        carouselDots()
      ],
    );
  }

  Widget buildView(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Image.asset(_currentImg, fit: BoxFit.contain, width: 1000.w));
  }

  Widget carouselDots() {
    List<Widget> list = [];
    for (int i = 0; i < widget.imageList.length; i++) {
      list.add(Container(
          height: 20.h,
          width: 20.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.imageList[i] == _currentImg
                  ? ThemeColors.coolgray900
                  : ThemeColors.white,
              border: Border.fromBorderSide(
                  BorderSide(color: ThemeColors.coolgray900, width: 1.w)))));
    }
    return SpacedRow(
      mainAxisAlignment: MainAxisAlignment.center,
      horizontalSpace: 10,
      children: list,
    );
  }
}
