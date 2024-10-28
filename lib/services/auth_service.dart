import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'https://ewelink-api-endpoint';

  // Perform API login request and return the token if successful
  Future<String?> authenticate(String username, String password) async {
    try {
      // final response = await http.post(
      //   Uri.parse('$baseUrl/auth'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode({'username': username, 'password': password}),
      // );

      if (username.toLowerCase() == "nadim.khoury@arkenergyae" && password == "nadim@nadim") {
        // final responseBody = jsonDecode(response.body);
        return "TOKEN";
        // return responseBody['token'];
      } else {
        // print("Login failed: ${response.body}");
        print("Login failed:");
        return null;
      }
    } catch (error) {
      print("Error during authentication: $error");
      return null;
    }
  }
}
