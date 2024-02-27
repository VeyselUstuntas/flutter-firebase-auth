import 'package:firebase_kullanimi/common/colors.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {

  final onPressed;
  final textColor;
  final buttonText;


  CustomTextButton({required this.onPressed, this.textColor = loginForgotPassColor,required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        onPressed();
      }, child: Text(buttonText,style: TextStyle(color: textColor),));
  }
}
