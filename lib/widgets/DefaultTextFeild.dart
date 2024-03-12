import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


import '../common/color.dart';
import '../common/global_widgets.dart';

class DefaultTextField extends StatefulWidget {
  DefaultTextField({super.key, this.suffixWidget ,
    required this.controller , this.hint, this.prefixWidget, this.pass, this.max, this.length});
  Widget? suffixWidget;
  Widget? prefixWidget;
  String? hint;
  TextEditingController controller;
  bool? pass;
  int? length;
  int? max;


  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if(value == null || value.isEmpty) {
          return "Please enter ${widget.hint} ";
        }
        return null;
      },
      controller: widget.controller,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
            borderSide: BorderSide(color: commonColor)
        ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: commonColor)
        ),
        focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: commonColor)
        ),
        disabledBorder:  const UnderlineInputBorder(
            borderSide: BorderSide(color: commonColor)
        ),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: commonColor)
        ),
        hintText: widget.hint,
        hintStyle: getTextStyle(),
        suffixIcon: widget.suffixWidget,
        prefixIcon: widget.prefixWidget,
      ),
      obscureText: widget.pass == true ? true: false,
      style: getTextStyle(),
      maxLines: widget.max,
      maxLength: widget.length,
    );
  }
}