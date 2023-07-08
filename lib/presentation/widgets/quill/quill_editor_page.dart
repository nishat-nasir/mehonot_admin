import 'package:auto_route/annotations.dart';import 'package:auto_route/auto_route.dart';import 'package:flutter_quill/flutter_quill.dart';import '../../template/template.dart';@RoutePage(name: "QuillEditorRoute")class QuillEditorPage extends StatefulWidget {  final Function(QuillController) onDone;  final QuillController? controller;  const QuillEditorPage({    Key? key,    required this.onDone,    this.controller,  }) : super(key: key);  @override  State<QuillEditorPage> createState() => _QuillEditorPageState();}class _QuillEditorPageState extends State<QuillEditorPage> {  final QuillController controller = QuillController.basic();  @override  Widget build(BuildContext context) {    if (widget.controller != null) {      controller.document = widget.controller!.document;    }    return SingleChildScrollView(        child: Column(children: [      QuillToolbar.basic(        controller: controller,        iconTheme: QuillIconTheme(          borderRadius: 20.r,          iconSelectedColor:              isDark(context) ? ThemeColors.blue600 : ThemeColors.gray900,          iconSelectedFillColor: ThemeColors.blue300,        ),        toolbarIconSize: 24,        multiRowsDisplay: false,        showBoldButton: true,        showItalicButton: false,        showUnderLineButton: false,        showStrikeThrough: false,        showColorButton: false,        showBackgroundColorButton: false,        showClearFormat: false,        showHeaderStyle: false,        showListCheck: false,        showIndent: false,        showQuote: false,        showSearchButton: false,        showLink: false,        showCodeBlock: false,        showInlineCode: false,        showSuperscript: false,        showRedo: false,        showUndo: false,        showSubscript: false,        sectionDividerSpace: 0,        showDividers: false,        showFontSize: true,        showFontFamily: false,        fontSizeValues: {          S(context).description: '12',          S(context).title: '18',          S(context).subTitle: '10',        },      ),      Padding(          padding: EdgeInsets.all(40.w),          child: Container(              width: MediaQuery.of(context).size.width,              decoration: BoxDecoration(                  color: isDark(context)                      ? ThemeColors.gray900                      : ThemeColors.blue100,                  borderRadius: BorderRadius.circular(20.r),                  border:                      Border.all(color: ThemeColors.coolgray400, width: 2.w)),              height: 1300.h,              padding: EdgeInsets.all(20.w),              child: LayoutBuilder(builder: (context, constraints) {                return SingleChildScrollView(                    child: QuillEditor.basic(                  controller: controller,                  readOnly: false,                ));              }))),      SpacedRow(        horizontalSpace: 30.w,        mainAxisAlignment: MainAxisAlignment.center,        children: [          SizedBox(            width: 400.w,            child: PrimaryButton(              buttonText: S(context).seeResult,              bgColor: ThemeColors.green600,              btnTextStyle:                  ThemeTextBold.k16.copyWith(color: ThemeColors.white),              onPressed: _onSeeResult,            ),          ),          SizedBox(              width: 400.w,              child: PrimaryButton(                  buttonText: S(context).save, onPressed: _onDone))        ],      ),    ]));  }  void _onDone() {    widget.onDone(controller);  }  void _onSeeResult() {    QuillController quillText = controller;    List<dynamic> jsonList = quillText.document.toDelta().toJson();    Map<String, dynamic> jsonDelta = {      'ops': jsonList,    };    QuillController convertJsonToQuillController(Map<String, dynamic> json) {      final delta = Delta.fromJson(jsonList);      return QuillController(          document: Document.fromDelta(delta),          selection: const TextSelection.collapsed(offset: 0));    }    showDialog(        context: context,        builder: (BuildContext context) {          return AlertDialog(              insetPadding: EdgeInsets.zero,              content: SizedBox(                  height: MediaQuery.of(context).size.height - 500.h,                  child: SpacedColumn(                      mainAxisAlignment: MainAxisAlignment.spaceBetween,                      children: [                        SizedBox(                            width: 800.w,                            height: MediaQuery.of(context).size.height - 650.h,                            child: QuillEditor(                              controller:                                  convertJsonToQuillController(jsonDelta),                              readOnly: true,                              focusNode: FocusNode(),                              scrollController: ScrollController(),                              scrollable: true,                              padding: EdgeInsets.zero,                              autoFocus: false,                              expands: true,                              showCursor: false,                            )),                        SizedBox(                            width: 400.w,                            child: TextButton(                              onPressed: () {                                Navigator.of(context).pop();                              },                              child: SizedText(text: S(context).close),                            ))                      ])));        });  }}