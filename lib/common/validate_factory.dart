
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../widgets/snackbar_textwidget.dart';
import 'color.dart';

abstract class Validate {
  void commonFunction(BuildContext context );
  factory Validate( {required String email, required String password }) {
    if(email.isEmpty){
      return NotifyInfoBar("Please enter name");
    }
    if(!EmailValidator.validate(email)) {
      return NotifyInfoBar("Please enter valid email");
    }
    if(password.isEmpty){
      return NotifyInfoBar("Please enter password");
    }

    return ValidationSuccess();
  }
}

abstract class SignInValidate {
  void commonFunction(BuildContext context );
  factory SignInValidate( {required String email, required String password , required String name, required String mobile}) {
    if(email.isEmpty){
      return NotifyInfoSignInBar("Please enter name");
    }
    if(!EmailValidator.validate(email)) {
      return NotifyInfoSignInBar("Please enter valid email");
    }
    if(password.isEmpty){
      return NotifyInfoSignInBar("Please enter password");
    }

    if(email.isEmpty) {
      return NotifyInfoSignInBar("Please enter email");
    }

    if(mobile.isEmpty) {
      return NotifyInfoSignInBar("Please enter email");
    }

    if(mobile.length < 10) {
      return NotifyInfoSignInBar("Please enter valid mobile number");
    }

    return ValidationSignInSuccess();
  }
}


class NotifyInfoBar implements Validate {
  final String content;

  NotifyInfoBar(this.content);
  @override
  void commonFunction(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: commonColor,
        content: TextWidget(fontSize: 15, wtg: FontWeight.w400, color: Colors.black, text: content,),
      ),
    );
    throw Exception(content);
  }

}

class ValidationSuccess implements Validate {
  @override
  void commonFunction(BuildContext context) {

  }
}



class NotifyInfoSignInBar implements SignInValidate {
  final String content;
  NotifyInfoSignInBar(this.content);
  @override
  void commonFunction(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: commonColor,
        content: TextWidget(fontSize: 15, wtg: FontWeight.w400, color: Colors.black, text: content,),
      ),
    );
    throw Exception(content);
  }

}

class ValidationSignInSuccess implements SignInValidate {
  @override
  void commonFunction(BuildContext context) {

  }

}


