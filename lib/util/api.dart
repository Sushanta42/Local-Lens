import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = "https://662180a927fcd16fa6c72720.mockapi.io";
  // static var headers = {
  //   "Accept": "application/json",
  //   "Content-Type": "application/json"
  // };
  static var client = http.Client();
}
