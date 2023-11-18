import 'package:dio/dio.dart';
import 'package:gameguru/services/server-url.dart';

Future<Map<String, dynamic>> fetchData() async {

  try {
    final response = await Dio().get('$uri/livescore');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to fetch data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<Map<String, dynamic>> liveScore(matchId) async {

  try{
    final response = await Dio().get('$uri/liveData/$matchId');
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }catch(e){
    throw Exception('Errors: $e' );
  }
}
