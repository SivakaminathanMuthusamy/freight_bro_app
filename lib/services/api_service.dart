import 'dart:convert';

import 'package:freightbro_app/models/api_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future<List<Employee>> fetchAPIData() async {
    Uri url =
        Uri.parse('https://604a08bd9251e100177cdbcb.mockapi.io/test/users');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body) as List;
        return data.map((json) => Employee.fromJson(json)).toList();
      } else {
        print(response.statusCode);
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
