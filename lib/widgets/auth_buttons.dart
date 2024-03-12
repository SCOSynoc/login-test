import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


import '../common/color.dart';
import '../common/global_widgets.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key, this.onPressed, this.diffColor});
  final Function()? onPressed;
  final Color? diffColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *0.45,
      height:MediaQuery.of(context).size.height *0.07 ,
      decoration: BoxDecoration(
          color: diffColor == null ? Colors.black : diffColor,
          borderRadius: BorderRadius.circular(25.0)
      ),
      child: MaterialButton(
          onPressed: onPressed,
          child: Text("Create an account", style: authTextStyle( diffColor != null? Colors.black: commonColor),)),
    )
    ;
  }
}

class LoginAccountButton extends StatelessWidget {
  const LoginAccountButton({super.key, this.onPressed, this.color});
  final Function()? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width *0.45,
        height:MediaQuery.of(context).size.height *0.07 ,
        decoration: BoxDecoration(
            color:color == null ? Colors.black : color,
            borderRadius: BorderRadius.circular(25.0)
        ),
        child: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Text("Login", style: authTextStyle(color != null ? Colors.black : commonColor),),
          onPressed: onPressed,
        ))
    ;
  }
}