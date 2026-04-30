import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum InputFieldFormat {phone, number, textOnly, regular}

class TextInputSearchField extends StatefulWidget {
  const TextInputSearchField(
      {Key? key,
        this.format = InputFieldFormat.regular,
        this.prefix,
        this.controller,
        this.hintText,
        this.maxLines,
        this.keyboardType,
        this.suffixIcon,
        this.enabled = true,
        this.onChange,
        this.validator,
        this.error,
        this.inputFormatter,
        this.onFieldSubmitted})
      : super(key: key);

  final InputFieldFormat format;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? prefix;
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool enabled;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator? validator;
  final String? error;

  @override
  State<TextInputSearchField> createState() => _TextInputSearchFieldState();
}

class _TextInputSearchFieldState extends State<TextInputSearchField> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SizedBox(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          TextFormField(
            inputFormatters: widget.inputFormatter,
            cursorColor: Colors.black,
            validator: widget.validator,
            onChanged: widget.onChange,
            enabled: widget.enabled,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: widget.onFieldSubmitted,
            controller: widget.controller,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'AzoSans',
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.normal,
            ),
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(left: 8.r),
              errorStyle: TextStyle(
                fontFamily: "AzoSans",
                color: Colors.white60,
                fontWeight: FontWeight.normal,
                fontSize: ScreenUtil().setSp(10),
              ),
              errorText: widget.error,
              suffixIcon: widget.suffixIcon,
              hintText: widget.hintText,
              disabledBorder: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.0),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.0),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.0),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}