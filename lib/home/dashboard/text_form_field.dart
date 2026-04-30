import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum InputFieldFormat {phone, number, textOnly, regular}

/// Text Input Field....

class TextInputField extends StatefulWidget {
  const TextInputField(
      {Key? key,
        this.format = InputFieldFormat.regular,
        this.copyPaste,
        this.prefix,
        this.controller,
        this.hintText,
        this.maxLines,
        this.errorStyle,
        this.keyboardType,
        this.suffixIcon,
        this.initialValue,
        this.enabled = true,
        this.onChange,
        this.onTap,
        this.validator,
        this.error,
        this.labelText,
        this.inputFormatter})
      : super(key: key);

  final bool? copyPaste;
  final InputFieldFormat format;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? prefix;
  final TextEditingController? controller;
  final String? hintText;
  final String? initialValue;
  final TextStyle? errorStyle;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool enabled;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChange;
  final FormFieldValidator? validator;
  final String? error;
  final VoidCallback? onTap;
  final Widget? labelText;

  @override
  TextInputFieldState createState() => TextInputFieldState();
}

class TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: widget.labelText,
        ),
        Padding(
          padding: EdgeInsets.only(top: 4.r),
          child: SizedBox(
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTap: widget.onTap,
              autocorrect: true,
              initialValue: widget.initialValue,
              inputFormatters: widget.inputFormatter,
              cursorColor: Colors.red,
              validator: widget.validator,
              onChanged: widget.onChange,
              enabled: widget.enabled,
              textInputAction: TextInputAction.next,
              controller: widget.controller,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'AzoSans',
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal),
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.only(left: 8.r),
                errorStyle: widget.errorStyle,
                errorText: widget.error,
                suffixIcon: widget.suffixIcon,
                hintText: widget.hintText,
                disabledBorder: InputBorder.none,
                hintStyle: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}