import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Widget leading;
  final String title;

  AppBarWidget({
    Key? key,
    required this.leading,
    required this.title,
  })  : preferredSize = Size.fromHeight(60.h),
        super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      leading: widget.leading,
      title: Padding(
        padding: EdgeInsets.only(
          top: 16.r,
        ),
        child: Text(widget.title,
            style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
