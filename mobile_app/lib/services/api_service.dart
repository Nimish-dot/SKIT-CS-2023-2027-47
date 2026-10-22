
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Replace with your forwarded backend URL if required.
  static const String baseUrl = 'http://localhost:5000/api';

  static Future<Map<String, dynamic>> registerAthlete({
    required String name,
    required String email,
    required String sport,
    String location = '',
    int? age,
  }) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/athletes/register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'name': name,
            'email': email,
            'sport': sport,
            'location': location,
             'age': ?age,
          }),
        )
        .timeout(const Duration(seconds: 15));

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 201 && data['success'] == true) {
      return data;
    }

    throw Exception(data['message'] ?? 'Athlete registration failed');
  }

  static Future<List<Map<String, dynamic>>> getAthletes() async {
    final response = await http
        .get(Uri.parse('$baseUrl/athletes'))
        .timeout(const Duration(seconds: 15));

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200 && data['success'] == true) {
      final athletes = data['athletes'] as List<dynamic>;

      return athletes
          .map((athlete) => Map<String, dynamic>.from(athlete as Map))
          .toList();
    }

    throw Exception(data['message'] ?? 'Could not retrieve athletes');
  }

  static Future<Map<String, dynamic>> createAssessment({
    required String athleteId,
    required String sport,
    String videoUrl = '',
  }) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/assessments'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'athleteId': athleteId,
            'sport': sport,
            'videoUrl': videoUrl,
          }),
        )
        .timeout(const Duration(seconds: 15));

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 201 && data['success'] == true) {
      return data;
    }

    throw Exception(data['message'] ?? 'Assessment creation failed');
  }

  static Future<bool> checkBackend() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/health'))
          .timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
