import '../template/template.dart';class ExperienceItem extends StatefulWidget {  String companyName;  String location;  String positionName;  String? description;  String startDate;  String endDate;  bool showDivider;  VoidCallback? onDeleteExpItem;  ExperienceItem({    Key? key,    required this.companyName,    required this.location,    required this.positionName,    required this.description,    required this.startDate,    required this.endDate,    required this.showDivider,    this.onDeleteExpItem,  }) : super(key: key);  @override  State<ExperienceItem> createState() => _ExperienceItemState();}class _ExperienceItemState extends State<ExperienceItem> {  @override  Widget build(BuildContext context) {    return SizedBox(        child: SpacedColumn(            crossAxisAlignment: CrossAxisAlignment.start,            children: [              SpacedRow(                  crossAxisAlignment: CrossAxisAlignment.center,                  mainAxisAlignment: MainAxisAlignment.spaceBetween,                  children: [                    SizedText(                        text: widget.companyName,                        textStyle: ThemeTextSemiBold.k14),                    if (widget.onDeleteExpItem != null)                      InkWell(                        onTap: widget.onDeleteExpItem,                        child: const HeroIcon(                          HeroIcons.xMark,                          style: HeroIconStyle.solid,                        ),                      )                  ]),              SizedText(                  text: widget.positionName, textStyle: ThemeTextSemiBold.k10),              SizedBox(height: 20.w),              SpacedColumn(verticalSpace: 20, children: [                SpacedRow(                    crossAxisAlignment: CrossAxisAlignment.center,                    horizontalSpace: 10,                    children: [                      Icon(Icons.calendar_month_outlined,                          color: isDark(context)                              ? ThemeColors.coolgray200                              : PrsmColorsDark.canvasColor,                          size: 24.h),                      SizedText(                          text: '${widget.startDate} - ${widget.endDate}',                          textStyle: ThemeTextRegular.k10)                    ]),                SpacedRow(                    crossAxisAlignment: CrossAxisAlignment.center,                    horizontalSpace: 10,                    children: [                      Icon(Icons.location_on_outlined,                          color: isDark(context)                              ? ThemeColors.coolgray200                              : PrsmColorsDark.canvasColor,                          size: 24.h),                      SizedText(                          text: widget.location,                          textStyle: ThemeTextRegular.k10)                    ])              ]),              SizedBox(height: 20.w),              SizedText(                  text: widget.description,                  softWrap: true,                  textAlign: TextAlign.justify,                  textStyle: ThemeTextRegular.k10),              if (widget.showDivider) const Divider()            ]));  }}