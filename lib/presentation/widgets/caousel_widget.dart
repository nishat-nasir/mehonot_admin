import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import '../template/template.dart';

class PrsmCarouselImageWidget extends StatefulWidget {
  final List<String> imageList;
  final double height;
  final bool autoPlay;
  final bool? showFromNetwork;

  const PrsmCarouselImageWidget({
    Key? key,
    required this.imageList,
    this.height = 320,
    this.autoPlay = false,
    this.showFromNetwork = true,
  }) : super(key: key);

  @override
  State<PrsmCarouselImageWidget> createState() =>
      _PrsmCarouselImageWidgetState();
}

class _PrsmCarouselImageWidgetState extends State<PrsmCarouselImageWidget> {
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
              child: (widget.showFromNetwork == true)
                  ? Image.network(e, fit: BoxFit.fitWidth, width: 1000.w)
                  : Image.asset(e, fit: BoxFit.fitWidth, width: 1000.w)))
              .toList(),
        ),
        carouselDots()
      ],
    );
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

class PrsmCarouselUploadImgWidget extends StatefulWidget {
  final double height;
  final bool autoPlay;
  final List<File> imageFiles;
  final bool showAddMoreImage;
  final VoidCallback? onAddImg;
  final Function(int)? onRemoveImg;

  const PrsmCarouselUploadImgWidget({
    Key? key,
    this.height = 330,
    this.autoPlay = false,
    required this.imageFiles,
    required this.showAddMoreImage,
    this.onAddImg,
    this.onRemoveImg,
  }) : super(key: key);

  @override
  State<PrsmCarouselUploadImgWidget> createState() =>
      _PrsmCarouselUploadImgWidgetState();
}

class _PrsmCarouselUploadImgWidgetState
    extends State<PrsmCarouselUploadImgWidget> {
  final CarouselController _carouselCntr = CarouselController();

  File? _currentImgFile;

  @override
  void initState() {
    super.initState();
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
                if (widget.imageFiles.isNotEmpty) {
                  _currentImgFile = widget.imageFiles[index];
                } else {
                  _currentImgFile = null;
                }
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
          items: _getCarouselItems(),
        ),
        carouselDots()
      ],
    );
  }

  List<Widget> _getCarouselItems() {
    List<Widget> items = [];

    if (widget.imageFiles.isNotEmpty) {
      items.addAll(
        widget.imageFiles.map((e) => Center(
            child: Stack(alignment: Alignment.center, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.file(
                  e,
                  fit: BoxFit.fitWidth,
                  height: widget.height.h,
                  width: 1000.w,
                ),
              ),
              Positioned(
                  top: 1,
                  right: 0,
                  child: InkWell(
                      onTap: () {
                        widget.onRemoveImg!(widget.imageFiles.indexOf(e));
                      },
                      child: const HeroIcon(
                        HeroIcons.xMark,
                        color: Colors.white,
                      )))
            ]))),
      );
    }

    if (widget.showAddMoreImage == true) {
      items.add(addMoreImagesButton());
    }

    return items;
  }

  Widget addMoreImagesButton() {
    return DottedBorder(
        strokeWidth: 2,
        dashPattern: const [4, 4],
        borderType: BorderType.RRect,
        radius: Radius.circular(16.r),
        color: ThemeColors.gray600,
        child: InkWell(
            onTap: widget.onAddImg,
            child: Container(
                decoration: BoxDecoration(
                  color: isDark(context)
                      ? ThemeColors.coolgray700
                      : ThemeColors.blue200,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                    child: HeroIcon(
                      HeroIcons.plus,
                      size: 200.w,
                      color: isDark(context)
                          ? ThemeColors.blue200
                          : ThemeColors.coolgray700,
                    )))));
  }

  Widget carouselDots() {
    List<Widget> list = [];
    for (int i = 0; i < widget.imageFiles.length; i++) {
      list.add(
        Container(
          height: 20.h,
          width: 20.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.imageFiles[i] == _currentImgFile
                ? ThemeColors.coolgray900
                : ThemeColors.white,
            border: Border.fromBorderSide(
              BorderSide(color: ThemeColors.coolgray900, width: 1.w),
            ),
          ),
        ),
      );
    }
    return SpacedRow(
      mainAxisAlignment: MainAxisAlignment.center,
      horizontalSpace: 10,
      children: list,
    );
  }
}

class PrsmCarouselBannerWidget extends StatefulWidget {
  final List<String> imageList;
  final double height;
  final bool autoPlay;
  final VoidCallback? onTap;
  final bool? showImgFromNetwork;

  const PrsmCarouselBannerWidget({
    Key? key,
    required this.imageList,
    this.height = 350,
    this.autoPlay = false,
    this.onTap,
    this.showImgFromNetwork = false,
  }) : super(key: key);

  @override
  State<PrsmCarouselBannerWidget> createState() =>
      _PrsmCarouselBannerWidgetState();
}

class _PrsmCarouselBannerWidgetState extends State<PrsmCarouselBannerWidget> {
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
            viewportFraction: 1,
            enlargeCenterPage: true,
            autoPlay: widget.autoPlay,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            scrollDirection: Axis.horizontal,
          ),
          items: widget.imageList
              .map((e) => InkWell(
              onTap: widget.onTap,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: widget.showImgFromNetwork == true
                      ? Image.network(e,
                      fit: BoxFit.fitWidth, width: 1000.w)
                      : Image.asset(e,
                      fit: BoxFit.fitWidth, width: 1000.w))))
              .toList(),
        ),
        carouselDots()
      ],
    );
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
