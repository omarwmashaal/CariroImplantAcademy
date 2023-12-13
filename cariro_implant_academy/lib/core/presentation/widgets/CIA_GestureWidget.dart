import 'package:flutter/cupertino.dart';

class CIA_GestureWidget extends StatelessWidget {
  CIA_GestureWidget({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);
  Widget child;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: onTap == null ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        child: child,
        onTap: ()=> onTap == null ? null : onTap!(),
      ),
    );
  }
}
