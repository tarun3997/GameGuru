import 'package:dio/dio.dart';
import 'package:gameguru/services/server-url.dart';

Future<Map<String, dynamic>> seriesSquads(seriesId) async{
  try{
    final response = await Dio().get('$uri/seriesSquads/$seriesId');
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }catch(e){
    throw Exception('Errors: $e' );
  }
}