import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:naturalrescue/src/ui/utils/app_url.dart';

class RegisterController extends GetxController {
  var registerProcess = false.obs;
  var error = '';

  Future<dynamic> register(String username, String password, String fullname,
      String email, String city) async {
    try {
      registerProcess(true);
      final headerData = {'Content-Type': 'application/json'};
      
      final data = {
        "username": username,
        "password": password,
        "first_name": fullname,
        "email": email,
        "Pais": 'PERU',
        "Ciudad": city
      };
      final response = await http.post(Uri.parse(AppUrl.REGISTER_URL),
          headers: headerData, body: json.encode(data));
      Map<String, dynamic> decodedResp = json.decode(response.body);
      if (decodedResp.containsKey('token')) {
        registerProcess(false);
      } else {
        error = 'Error al registrar';
      }
    } finally {
      registerProcess(false);
    }

    return error;
  }
}
