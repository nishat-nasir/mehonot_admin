import '../../template/template.dart';class InfoBanner extends StatelessWidget {  String? imageUrl;  String topText;  String bottomText;  Color topTextColor;  Color bottomTextColor;  Color backgroundColor;  InfoBanner(      {Key? key,      this.topTextColor = ThemeColors.coolgray800,      this.bottomTextColor = ThemeColors.coolgray500,      this.backgroundColor = ThemeColors.white,      this.imageUrl,      required this.bottomText,      required this.topText})      : super(key: key);  @override  Widget build(BuildContext context) {    return Container(        color: backgroundColor,        child: Row(children: [          if (imageUrl != null && imageUrl!.isNotEmpty)            ImagePlaceholder(imageUrl: imageUrl),          SizedBox(width: 24.w),          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [            SizedText(              text: topText,              textStyle: ThemeTextSemiBold.k14.apply(color: topTextColor),            ),            SizedText(                text: bottomText,                textStyle: ThemeTextRegular.k10.apply(color: bottomTextColor))          ])        ]));  }}class ImagePlaceholder extends StatelessWidget {  final String? imageUrl;  final double width;  final double height;  ImagePlaceholder({    this.width = 50,    this.height = 50,    this.imageUrl,  });  @override  Widget build(BuildContext context) {    return SizedBox(      width: width.w,      height: height.w,      child: Image.asset(        'assets/images/png/person_icon.png',      ),    );  }}