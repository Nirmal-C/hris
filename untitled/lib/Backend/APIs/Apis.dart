import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/attendance_model.dart';

class ApiService {
  static Future<Map<String, dynamic>> getProfile(String token) async {
    print('Token in Function :$token');
    final response = await http.get(
      Uri.parse('http://hris.accelution.lk/api/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    print('Token after Function :$token');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<DashboardData> fetchDashboardData(String token) async {
    final response = await http.get(
      Uri.parse('http://hris.accelution.lk/api/dashboard'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return DashboardData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load dashboard data');
    }
  }
}
