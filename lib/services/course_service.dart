import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lmsalfa/models/course.dart';

class CourseService {
  final String apiUrl = 'https://your-api.com/courses';

  Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<Course> fetchCourseById(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Course.fromJson(json);
    } else {
      throw Exception('Course not found');
    }
  }
}