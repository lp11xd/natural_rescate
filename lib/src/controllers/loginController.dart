import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:naturalrescue/src/ui/utils/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var loginProcess = false.obs;
  var error = '';

  Future<dynamic> login(String username, String password) async {
    try {
      loginProcess(true);
      final headerData = {'Content-Type': 'application/json'};
      final data = {"username": username, "password": password};
      final response = await http.post(Uri.parse(AppUrl.LOGIN_URL),
          headers: headerData, body: jsonEncode(data));
      Map<String, dynamic> decodedResp = json.decode(response.body);
      if (decodedResp.containsKey('token')) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", decodedResp['token']);
      }else{
        error = decodedResp['detail'];
      }
    } finally {
      loginProcess(false);
    }

    return error;
  }
}
