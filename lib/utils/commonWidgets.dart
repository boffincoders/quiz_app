import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:quiz_app/utils/AppColor.dart';

class CommonWidgets {
  CommonWidgets._();

  static getTextStyle({double? fontSize, FontWeight? fontWeight, Color? textColor}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
    );
  }

  static getDecoration({BoxBorder? boxBorder, BorderRadiusGeometry? boxBorderRadius, Color? boxColor, Gradient? gradient, Color? borderColor}) {
    return BoxDecoration(color: boxColor, border: boxBorder, borderRadius: boxBorderRadius, gradient: gradient);
  }

  static getTextFormField(
      {TextEditingController? controller, String? hintText, FocusNode? focusNode, TextInputAction? keyboardAction, TextInputType? keyboardType, var submitted, var validator}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 6,
              blurRadius: 7,
              offset: const Offset(0, -1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        controller: controller,
        textInputAction: keyboardAction,
        textCapitalization: TextCapitalization.none,
        maxLines: 1,
        onFieldSubmitted: submitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.black),
          contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  static getPasswordTextFormField(
      {TextEditingController? controller, String? hintText, FocusNode? focusNode, TextInputAction? keyboardAction, TextInputType? keyboardType, var submitted, var validator}) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 6,
                  blurRadius: 7,
                  offset: const Offset(0, -1), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(30)),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            onFieldSubmitted: submitted,
            obscureText: true,
            textAlign: TextAlign.center,
            keyboardType: keyboardType,
            cursorColor: Colors.black,
            controller: controller,
            focusNode: focusNode,
            textInputAction: keyboardAction,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(color: AppColors.black),
              contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  static getSizedBox({double? height, double? width}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static getButton({String? btnText, TextStyle? btnTextStyle}) {
    return Container(
      alignment: Alignment.center,
      height: 45,
      width: 150,
      decoration: BoxDecoration(border: Border.all(color: Colors.lightBlueAccent), borderRadius: BorderRadius.circular(40.0), color: AppColors.white),
      child: Text(
        btnText!,
        style: btnTextStyle,
      ),
    );
  }

  static getGradientButton({String? btnText, TextStyle? btnTextStyle, bool? isLoading}) {
    return Container(
      alignment: Alignment.center,
      height: 45,
      width: 150,
      decoration: BoxDecoration(
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: [Colors.purple, Colors.deepPurpleAccent]),
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: isLoading!
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Text(
              btnText!,
              style: btnTextStyle,
            ),
    );
  }

  static showToast({ToastGravity? toastGravity, Toast? toast, String? msg}) {
    return Fluttertoast.showToast(
      msg: msg!,
      toastLength: toast,
      gravity: toastGravity,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.textGradientColor,
      textColor: AppColors.white,
      fontSize: 16.0,
    );
  }

  static bool? validateEmail(String? value) {
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (value != null || value!.isNotEmpty) {
      if (regex.hasMatch(value)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static bool? validatePassword(String? value) {
    String pattern = r'^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$';
    RegExp regex = RegExp(pattern);
    if (value != null || value!.isNotEmpty) {
      if (regex.hasMatch(value)) {
        return true;
      } else {
        return false;
      }
    } else {
      return null;
    }
  }

  static showSnackBar(BuildContext context, String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppColors.gradientColor,
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      duration: const Duration(seconds: 3),
    ));
  }

  static int? checkStatus(Response response) {
    var statusCode = response.statusCode;
    switch (statusCode) {
      case 200:
        {
          var data = jsonDecode(response.body);
        }
        break;

      case 401:
        {
          var data = jsonDecode(response.body);
        }
        break;
      case 400:
        {
          var data = jsonDecode(response.body);
        }
        break;

      default:
        {
          print("Invalid choice");
        }
        break;
    }
    return statusCode;
  }


  static getAddQuestionTextFormField(
      {TextEditingController? controller,
      String? hintText,
      FocusNode? focusNode,
      TextInputAction? keyboardAction,
      TextInputType? keyboardType,
      var submitted,
      var validator,
      GestureTapCallback? onTap,
      Color? color}) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 6,
                  blurRadius: 7,
                  offset: const Offset(0, -1), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(30)),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            keyboardType: keyboardType,
            cursorColor: Colors.black,
            controller: controller,
            textInputAction: keyboardAction,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
            onFieldSubmitted: submitted,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(color: AppColors.black),
              contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        GestureDetector(
          onTap: onTap!,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(border: Border.all(color: Colors.green, width: 2), borderRadius: BorderRadius.circular(60)),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(60)),
            ),
          ),
        ),
      ],
    );
  }
}
