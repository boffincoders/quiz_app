import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/ApiService/ApiUrls.dart';
import 'package:quiz_app/Models/AuthenticationModel/registrationModel.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/utils/commonWidgets.dart';

import '../../Models/AuthenticationModel/LoginModelClass.dart';

class AuthenticationServices {
  AuthenticationServices._();

  static var response;

  static Future<RegistrationModel?> signup({String? email, String? password, String? name, String? phoneNumber}) async {
    RegistrationModel registrationModel = RegistrationModel();
    var data = {"name": name, "email": email, "password": password, "method": "register"};
    var url = Uri.parse(ApiUrl.Url);

    try {
      var response = await http.post(url, body: data);

      if (CommonWidgets.checkStatus(response) == 200) {
        var data = jsonDecode(response.body);

        registrationModel = await RegistrationModel.fromJson(data);

        return registrationModel;
      } else {
        var registrationData = jsonDecode(response.body);
        CommonWidgets.showToast(msg: registrationData["errors"][0], toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<LoginModel?> login({String? email, String? password}) async {
    var data = {"email": email, "password": password, "method": "login"};
    var url = Uri.parse(ApiUrl.Url);

    try {
      var response = await http.post(url, body: data);
      if (CommonWidgets.checkStatus(response) == 200) {
        var loginData = jsonDecode(response.body);
        LoginModel loginModel =  LoginModel.fromJson(loginData);
        var token = loginData["data"]["jwt"];
        var role = loginData["data"]["role"];
        prefs!.setString("token", token);
        prefs!.setString("role", role);

        return loginModel;
      } else {
        var loginData = jsonDecode(response.body);
        CommonWidgets.showToast(msg: loginData["error"][0], toastGravity: ToastGravity.TOP, toast: Toast.LENGTH_SHORT);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
