import 'package:mehonot_admin/presentation/template/template.dart';

class AddRemoveEditButton extends StatefulWidget {
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final ValueChanged onSubmit;
  // final OrderItemRes product;
  AddRemoveEditButton({
    Key? key,
    required this.onAdd,
    // required this.product,
    required this.onRemove,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AddRemoveEditButton> createState() => _AddRemoveEditButtonState();
}

class _AddRemoveEditButtonState extends State<AddRemoveEditButton> {
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasPrimaryFocus) {}
      // if (focusNode.hasPrimaryFocus) {
      //   if (widget.product.qty.toInt() == 1) {
      //     widget.product.qty = 0;
      //   }
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     border: Border.all(
      //       width: 2,
      //       color: ThemeColors.coolgray200,
      //     ),
      //     borderRadius: BorderRadius.circular(24.r),
      //     color: ThemeColors.white),
      height: 63.h,
      // padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SpacedRow(
        horizontalSpace: 25,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: widget.onRemove,
            child: HeroIcon(
              HeroIcons.minus,
              color: ThemeColors.coolgray900,
              size: 40.h,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: ThemeColors.coolgray200,
                ),
                borderRadius: BorderRadius.circular(24.r),
                color: ThemeColors.white),
            width: 83.w,
            alignment: Alignment.center,
            child: EditableText(
              selectionColor: Colors.deepOrange,
              autofocus: false,
              maxLines: null,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              backgroundCursorColor: Colors.amber,
              cursorColor: Colors.deepOrange,
              style: ThemeTextSemiBold.k32.copyWith(
                color: ThemeColors.coolgray900,
                decorationThickness: 0.001,
              ),
              focusNode: focusNode,
              onSubmitted: widget.onSubmit,
              //     (val) {
              //   // double newQty = val.isEmpty ? 0 : double.parse(val);
              //   // if (newQty > 0) {
              //   //   widget.product.qty = double.parse(val);
              //   //   appStore.dispatch(
              //   //       UpdateBasketAction(selectedItem: widget.product));
              //   //   appStore.dispatch(GetIncrementItemQtyFromCartAction);
              //   //   appStore.dispatch(GetDecrementItemQtyFromCartAction);
              //   // } else {
              //   //   appStore.dispatch(
              //   //       UpdateBasketAction(selectedItem: widget.product));
              //   //   appStore.dispatch(GetIncrementItemQtyFromCartAction);
              //   //   appStore.dispatch(GetDecrementItemQtyFromCartAction);
              //   // }
              // },
              controller: TextEditingController(text: ""),
            ),
          ),
          //
          // SizedText(
          //   text: qty.toString(),
          //   textStyle:
          //       ThemeTextSemibold.k32.copyWith(color: ThemeColors.coolgray900),
          // ),
          InkWell(
            onTap: widget.onAdd,
            child: HeroIcon(
              HeroIcons.plus,
              color: ThemeColors.coolgray900,
              size: 40.h,
            ),
          ),
        ],
      ),
    );
  }
}
