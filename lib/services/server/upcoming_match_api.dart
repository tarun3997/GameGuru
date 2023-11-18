import 'package:dio/dio.dart';
import 'package:gameguru/services/server-url.dart';

Future<Map<String, dynamic>> upcomingMatchData() async {
  try{
    final response = await Dio().get('$uri/upcoming-match');
    if (response.statusCode == 200){
      return response.data;
    }else {
      throw Exception('Failed to fetch data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}