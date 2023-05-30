import 'dart:io';import 'package:auto_route/annotations.dart';import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';import 'package:intl/intl.dart';import 'package:mehonot_admin/manager/models/Banner/banner_md.dart';import '../../../manager/redux/states/ads_state.dart';import '../../template/template.dart';import '../../utils/common/validators.dart';import '../../widgets/image_upload.dart';@RoutePage()class BannerEditPage extends StatefulWidget {  BannerModel bannerMd;  BannerEditPage({Key? key, required this.bannerMd}) : super(key: key);  @override  State<BannerEditPage> createState() => _BannerEditPageState();}class _BannerEditPageState extends State<BannerEditPage> {  final GlobalKey<FormState> editBannerFormKey = GlobalKey<FormState>();  TextEditingController bannerTitleCntr = TextEditingController();  TextEditingController bannerDescCntr = TextEditingController();  TextEditingController companyCntr = TextEditingController();  TextEditingController emailCntr = TextEditingController();  TextEditingController phoneCntr = TextEditingController();  TextEditingController startDateCntr = TextEditingController();  TextEditingController endDateCntr = TextEditingController();  DateTime editBannerStartDate = DateTime.now();  DateTime editBannerEndDate = DateTime.now();  late String _bannerType;  bool jobIsCreate = false;  File bannerImage = File("");  String? imageUrlToDelete;  String? imageUrl;  late BannerModel bannerModel;  @override  void dispose() {    bannerTitleCntr.dispose();    bannerDescCntr.dispose();    companyCntr.dispose();    emailCntr.dispose();    phoneCntr.dispose();    super.dispose();  }  @override  void initState() {    super.initState();    bannerModel = widget.bannerMd;    imageUrl = bannerModel.image;    bannerTitleCntr.text = bannerModel.title;    bannerDescCntr.text = bannerModel.description ?? "";    companyCntr.text = bannerModel.companyName;    emailCntr.text = bannerModel.email ?? "";    phoneCntr.text = bannerModel.phone ?? "";    _bannerType = bannerModel.bannerType;  }  @override  Widget build(BuildContext context) {    return Form(        key: editBannerFormKey,        child: Padding(          padding: EdgeInsets.all(40.w),          child: SingleChildScrollView(              child: SpacedColumn(verticalSpace: 40, children: [            _buildTitleSec(),            _buildImageSec(),            _buildCompanyNameSec(),            _buildEmailSec(),            _buildPhoneSec(),            _buildDurationSec(),            _buildDescSec(),            _buildBannerTypeSec(),            _buildButtonSec(context)          ])),        ));  }  Widget _buildTitleSec() {    return SpacedColumn(children: [      Align(          alignment: Alignment.centerLeft,          child: SizedText(              text: S(context).title, textStyle: ThemeTextSemiBold.k14)),      PrsmInputField(        controller: bannerTitleCntr,        maxLines: 5,        enableShadow: false,        validator: Validator(context).validateField,        defaultBorderColor: ThemeColors.coolgray300,      ),    ]);  }  Widget _buildImageSec() {    return SpacedColumn(children: [      divider(),      PrsmImageUpload(          imageNetUrls: [imageUrl ?? ""],          maxImageCount: 1,          onRemoveNetworkImg: (index) {            if (imageUrl != null && imageUrl!.isNotEmpty) {              setState(() {                imageUrlToDelete = imageUrl;                imageUrl = "";              });            }          },          onImageSelected: (imageFile, image) {            logger("Image Selected");            logger(imageFile);            logger(image);            setState(() {              bannerImage = imageFile[0];            });          }),      divider(),    ]);  }  Widget _buildCompanyNameSec() {    return SpacedColumn(children: [      Align(          alignment: Alignment.centerLeft,          child: SizedText(              text: "Company Name", textStyle: ThemeTextSemiBold.k14)),      SizedBox(          width: MediaQuery.of(context).size.width - 100.w,          child: PrsmInputField(            controller: companyCntr,            validator: Validator(context).validateField,          ))    ]);  }  Widget _buildEmailSec() {    return SpacedColumn(children: [      Align(          alignment: Alignment.centerLeft,          child: SizedText(text: "Email", textStyle: ThemeTextSemiBold.k14)),      SizedBox(          width: MediaQuery.of(context).size.width - 100.w,          child: PrsmInputField(            controller: emailCntr,            validator: Validator(context).validateField,          ))    ]);  }  Widget _buildPhoneSec() {    return SpacedColumn(children: [      Align(          alignment: Alignment.centerLeft,          child: SizedText(              text: "Phone number", textStyle: ThemeTextSemiBold.k14)),      SizedBox(          width: MediaQuery.of(context).size.width - 100.w,          child: PrsmInputField(            controller: phoneCntr,            formatter: [              MaskedInputFormatter('00000000000',                  allowedCharMatcher: RegExp(r'[0-9]'))            ],            validator: Validator(context).validatePhone,          ))    ]);  }  Widget _buildDurationSec() {    return SpacedColumn(children: [      Align(          alignment: Alignment.centerLeft,          child: SizedText(text: "Duration", textStyle: ThemeTextSemiBold.k14)),      SpacedRow(          crossAxisAlignment: CrossAxisAlignment.center,          mainAxisAlignment: MainAxisAlignment.spaceBetween,          children: [            SizedBox(              width: (MediaQuery.of(context).size.width / 2) - 80.w,              child: PrsmInputField(                enabled: false,                hintText: "Start date",                onTap: () => showDateCalendarPopup(context, true),              ),            ),            SizedBox(              width: (MediaQuery.of(context).size.width / 2) - 80.w,              child: PrsmInputField(                enabled: false,                hintText: "End date",                onTap: () => showDateCalendarPopup(context, false),              ),            )          ])    ]);  }  Widget _buildDescSec() {    return SpacedColumn(children: [      Align(          alignment: Alignment.centerLeft,          child:              SizedText(text: "Description", textStyle: ThemeTextSemiBold.k14)),      PrsmInputField(        controller: bannerDescCntr,        maxLines: 5,        enableShadow: false,        validator: Validator(context).validateField,        defaultBorderColor: ThemeColors.coolgray300,      ),    ]);  }  Widget _buildBannerTypeSec() {    return SpacedColumn(children: [      Align(          alignment: Alignment.centerLeft,          child: SizedText(              text: "Banner choice", textStyle: ThemeTextSemiBold.k14)),      SizedBox(          width: MediaQuery.of(context).size.width - 100.w,          child: PrsmDropdown(              listValues: const ["home", "setting"],              value: _bannerType,              onChanged: (val) {                setState(() {                  _bannerType = val;                });              }))    ]);  }  Widget _buildButtonSec(BuildContext context) {    return SpacedColumn(children: [      divider(),      PrimaryButton(          buttonText: S(context).update,          buttonSize: ButtonSize.L,          onPressed: () async {            if (editBannerFormKey.currentState!.validate()) {              showConfirmJobPostPopup(context, false);            } else {              logger("Validation Error");            }          }),    ]);  }  Widget divider() {    return const Divider(      color: ThemeColors.coolgray300,    );  }  void showConfirmJobPostPopup(BuildContext context, bool? updateJob) {    showDialog(        context: context,        builder: (BuildContext context) {          return AlertDialog(            title: const Text("Confirm Banner update"),            content: const Text("Are you sure you want to Update this banner?"),            actions: [              TextButton(                  onPressed: () {                    Navigator.pop(context);                  },                  child: Text(S(context).cancel)),              TextButton(                  onPressed: () {                    editBanner();                    Navigator.pop(context);                  },                  child: Text(S(context).confirm)),            ],          );        });  }  showDateCalendarPopup(BuildContext context, bool startDate) async {    final DateTime? picked = await showDatePicker(        context: context,        initialDate: DateTime.now(),        firstDate: DateTime.now(),        lastDate: DateTime(2101));    if (picked != null) {      setState(() {        if (startDate) {          editBannerStartDate = picked;          startDateCntr.text = DateFormat('yyyy-MM-dd').format(picked);        } else {          editBannerEndDate = picked;          endDateCntr.text = DateFormat('yyyy-MM-dd').format(picked);        }      });    }  }  editBanner() async {    bool success = await appStore.dispatch(GetUpdatedBannersAction(        bannerImgToAdd: bannerImage,        imageUrlToDelete: imageUrlToDelete,        bannerType: _bannerType,        bannerModel: BannerModel(          title: bannerTitleCntr.text,          description: bannerDescCntr.text,          companyName: companyCntr.text,          email: emailCntr.text,          bannerType: _bannerType,          id: "",          postedById: "",          phone: '',          image: '',          createdAt: '',          removeAt: '',        )));    if (success) {      if (context.mounted) {        showDialog(            barrierDismissible: false,            context: context,            builder: (BuildContext context) {              return AlertDialog(                title: const Text("Success"),                content: const Text("Banner created successfully"),                actions: [                  TextButton(                      onPressed: () async {                        Navigator.pop(context);                        await appStore.dispatch(GetHomeBannersAction());                        await appStore.dispatch(GetSettingsBannersAction());                      },                      child: const Text("Ok"))                ],              );            });      }    }  }}