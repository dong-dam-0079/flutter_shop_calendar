import 'package:flutter/material.dart';

import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';

class CommonSwitch extends StatefulWidget {
  const CommonSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<CommonSwitch> createState() => _CommonSwitchState();
}

class _CommonSwitchState extends State<CommonSwitch>
    with SingleTickerProviderStateMixin {
  late Animation? _circleAnimation;
  late AnimationController? _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 60),
    );

    _circleAnimation = AlignmentTween(
      begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: DimensRes.sp48,
            height: DimensRes.sp24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DimensRes.sp24),
              color: _circleAnimation!.value == Alignment.centerLeft
                  ? ColorsRes.textDisable
                  : ColorsRes.primary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(DimensRes.sp4),
              child: Container(
                alignment:
                    widget.value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: DimensRes.sp16,
                  height: DimensRes.sp16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
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
