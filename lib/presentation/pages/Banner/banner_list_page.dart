import 'package:auto_route/annotations.dart';import 'package:auto_route/auto_route.dart';import 'package:mehonot_admin/manager/navigation/router.gr.dart';import '../../template/template.dart';import '../../widgets/containers/banner_container.dart';@RoutePage()class BannerListPage extends StatefulWidget {  const BannerListPage({Key? key}) : super(key: key);  @override  State<BannerListPage> createState() => _BannerListPageState();}class _BannerListPageState extends State<BannerListPage> {  @override  Widget build(BuildContext context) {    return Padding(        padding: EdgeInsets.all(20.w),        child: SingleChildScrollView(            child: SpacedColumn(          crossAxisAlignment: CrossAxisAlignment.start,          children: [            SpacedRow(              mainAxisAlignment: MainAxisAlignment.spaceBetween,              crossAxisAlignment: CrossAxisAlignment.center,              children: [                SizedText(                    text: "Banners list : 40", textStyle: ThemeTextRegular.k12),                SizedBox(                    width: 180.w,                    child: PrimaryButton(                        buttonText: "Create",                        buttonSize: ButtonSize.L,                        buttonType: ButtonType.Link,                        btnTextStyle: ThemeTextRegular.k12,                        linkTypeBtnColor: ThemeColors.blue800,                        onPressed: () {                          context.pushRoute(const BannerCreateRoute());                        }))              ],            ),            _buildBannerList(context),          ],        )));  }  Widget _buildBannerList(BuildContext context) {    List<Widget> list = [];    for (int i = 0; i < 2; i++) {      list.add(BannerContainer(        onTap: () {},        onReqDecline: () {},        onReqAccept: () {},        onEdit: () {          context.pushRoute(const BannerEditRoute());        },      ));    }    return SpacedColumn(      crossAxisAlignment: CrossAxisAlignment.center,      verticalSpace: 30.h,      children: list,    );  }}