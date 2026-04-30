import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatefulWidget {
  final Widget? title;
  final VoidCallback? onTap;
  final Color color;
  final double maxHeight;
  const ButtonWidget({Key? key, this.title, this.onTap,required this.color,required this.maxHeight}) : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MaterialButton(
      splashColor: Colors.white24,
      onPressed: widget.onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60),
      ),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white12),
          color: widget.color,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Container(
          constraints: BoxConstraints(
              maxHeight: widget.maxHeight, maxWidth: ScreenUtil().screenWidth),
          alignment: Alignment.center,
          child: widget.title,
        ),
      ),
    );
  }
}

class PunchButtonWidget extends StatefulWidget {
  final Widget? title;
  final VoidCallback? onTap;
  final Color color;
  final double maxHeight;
  final double? maxWidth;
  const PunchButtonWidget({Key? key, this.title, this.onTap,required this.color,required this.maxHeight, this.maxWidth}) : super(key: key);

  @override
  State<PunchButtonWidget> createState() => _PunchButtonWidgetState();
}

class _PunchButtonWidgetState extends State<PunchButtonWidget> {
  static const IconData fingerprintOutlined = IconData(0xf075, fontFamily: 'MaterialIcons');
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MaterialButton(
      splashColor: Colors.white24,
      onPressed: widget.onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60),
      ),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white12),
          color: widget.color,
          borderRadius: BorderRadius.circular(60),
        ),
        // decoration: BoxDecoration(
        //   image: const DecorationImage(
        //     image: AssetImage('assets/mainlogo.png'),
        //     fit: BoxFit.cover,
        //   ),
        //   border: Border.all(color: Colors.white12),
        //   color: widget.color,
        //   borderRadius: BorderRadius.circular(60),
        // ),
        child: Container(
          constraints: BoxConstraints(
              maxHeight: widget.maxHeight, maxWidth: widget.maxWidth!),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 8.r),
            child: widget.title!,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     const CircleAvatar(
          //         radius: 18,
          //         backgroundColor: Colors.white24,
          //         child: Icon(fingerprintOutlined, size: 30,color: Colors.white)),
          //     Padding(
          //       padding: EdgeInsets.only(left: 8.r),
          //       child: widget.title!,
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
