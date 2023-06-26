import 'package:auto_route/annotations.dart';import 'package:auto_route/auto_route.dart';import 'package:flutter_quill/flutter_quill.dart';import '../../../template/template.dart';@RoutePage(name: "QuillTestRoute")class QuillTest extends StatefulWidget {  final Function(QuillController) onDone;  final QuillController? controller;  const QuillTest({    Key? key,    required this.onDone,    this.controller,  }) : super(key: key);  @override  State<QuillTest> createState() => _QuillTestState();}class _QuillTestState extends State<QuillTest> {  final QuillController _controller = QuillController.basic();  @override  Widget build(BuildContext context) {    if (widget.controller != null) {      _controller.document = widget.controller!.document;    }    return SizedBox(        height: 900.h,        width: 800.w,        child: SingleChildScrollView(            child: Column(children: [          QuillToolbar.basic(            controller: _controller,            toolbarIconSize: 24,            multiRowsDisplay: false,            showBoldButton: true,            showItalicButton: false,            showUnderLineButton: false,            showStrikeThrough: false,            showColorButton: false,            showBackgroundColorButton: false,            showClearFormat: false,            showHeaderStyle: false,            showListCheck: false,            showIndent: false,            showQuote: false,            showSearchButton: false,            showLink: false,            showCodeBlock: false,            showInlineCode: false,            showSuperscript: false,            showRedo: false,            showUndo: false,            showSubscript: false,            sectionDividerSpace: 0,            showDividers: false,            showFontSize: true,            showFontFamily: false,            fontSizeValues: const {              'Subtitle': '10',              'Description': '14',              'Title': '28'            },            color: isDark(context) ? ThemeColors.blue900 : ThemeColors.blue100,          ),          Padding(              padding: EdgeInsets.all(40.w),              child: Container(                  width: MediaQuery.of(context).size.width,                  height: 800.h,                  padding: EdgeInsets.all(70.w),                  color: isDark(context)                      ? ThemeColors.gray900                      : ThemeColors.blue100,                  child: LayoutBuilder(builder: (context, constraints) {                    return SingleChildScrollView(                        child: QuillEditor.basic(                      controller: _controller,                      readOnly: false,                    ));                  }))),          SizedBox(            width: 500.w,            child: PrimaryButton(              buttonText: "See Result",              buttonType: ButtonType.Ghost,              onPressed: _onSeeResult,            ),          ),          SizedBox(height: 50.h),          SizedBox(              width: 500.w,              child: PrimaryButton(buttonText: "Done", onPressed: _onDone))        ])));  }  void _onDone() {    widget.onDone(_controller);  }  void _onSeeResult() {    QuillController quillText = _controller;    List<dynamic> jsonList = quillText.document.toDelta().toJson();    Map<String, dynamic> jsonDelta = {      'ops': jsonList,    };    QuillController convertJsonToQuillController(Map<String, dynamic> json) {      final delta = Delta.fromJson(jsonList);      return QuillController(          document: Document.fromDelta(delta),          selection: const TextSelection.collapsed(offset: 0));    }    showDialog(        context: context,        builder: (BuildContext context) {          return AlertDialog(              content: SizedBox(                  width: 800.w,                  height: 1000.h,                  child: SpacedColumn(                      mainAxisAlignment: MainAxisAlignment.spaceBetween,                      children: [                        SizedBox(                            width: 800.w,                            height: 880.h,                            child: QuillEditor(                              controller:                                  convertJsonToQuillController(jsonDelta),                              readOnly: true,                              focusNode: FocusNode(),                              scrollController: ScrollController(),                              scrollable: true,                              padding: EdgeInsets.zero,                              autoFocus: false,                              expands: true,                              showCursor: false,                            )),                        SizedBox(                            width: 200.w,                            child: TextButton(                              onPressed: () {                                Navigator.of(context).pop();                              },                              child: const SizedText(text: "Close"),                            ))                      ])));        });  }}