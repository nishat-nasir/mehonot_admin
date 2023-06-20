import '../template/template.dart';

class PrsmToggle extends StatefulWidget {
  /// * [value] determines whether this switch is on or off.
  /// * [onToggle] is called when the user toggles the switch on or off.

  const PrsmToggle({
    Key? key,
    required this.value,
    required this.onToggle,
    this.bgColor,
    this.disabled = false,
    this.toggleWidth,
    this.toggleHeight,
    this.toggleSize,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool> onToggle;
  final bool disabled;
  final Color? bgColor;
  final double? toggleWidth;
  final double? toggleHeight;
  final double? toggleSize;

  @override
  _PrsmToggleState createState() => _PrsmToggleState();
}

class _PrsmToggleState extends State<PrsmToggle>
    with SingleTickerProviderStateMixin {
  late final Animation _toggleAnimation;
  late final AnimationController _animationController;
  final Duration _duration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
      duration: _duration,
    );
    _toggleAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PrsmToggle oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value == widget.value) return;

    if (widget.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color _toggleColor = ThemeColors.white;
    Color _switchColor = ThemeColors.white;
    Border? _switchBorder;
    Border? _toggleBorder;

    if (widget.value) {
      _toggleColor = ThemeColors.white;
      _switchColor = widget.bgColor ?? ThemeColors.orange500;
    } else {
      _switchColor = ThemeColors.coolgray200;
    }

    double _toggleSize = widget.toggleSize ?? 20.0;
    double _borderRadius = 37.0;
    double _padding = 2.0;
    double _width = widget.toggleWidth ?? 54.0;
    double _height = widget.toggleHeight ?? 24.0;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SizedBox(
          width: _width,
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onHorizontalDragStart: (details) {
                if (!widget.disabled) {
                  if (widget.value) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }

                  widget.onToggle(!widget.value);
                }
              },
              onTap: () {
                if (!widget.disabled) {
                  if (widget.value) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                  widget.onToggle(!widget.value);
                }
              },
              child: Opacity(
                opacity: widget.disabled ? 0.6 : 1,
                child: Container(
                  width: _width,
                  height: _height,
                  padding: EdgeInsets.all(_padding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_borderRadius),
                      border: _switchBorder,
                      gradient: widget.value
                          ? PrsmColorsCommon.secondaryContainerColor
                          : const LinearGradient(colors: [
                              ThemeColors.lightblue100,
                              ThemeColors.lightblue200,
                            ])),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: _toggleAnimation.value,
                        child: PhysicalModel(
                          elevation: 1,
                          color: ThemeColors.black.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(10000),
                          child: Container(
                            width: _toggleSize,
                            height: _toggleSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _toggleColor,
                              border: _toggleBorder,
                            ),
                            child: AnimatedOpacity(
                              opacity: !widget.value ? 1.0 : 0.0,
                              duration: _duration,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
