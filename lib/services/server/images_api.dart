import 'package:dio/dio.dart';
import 'package:gameguru/services/server-url.dart';

class ImageService {
  final Dio dio = Dio();

  Future<List<int>> fetchImage(String imageId) async {
    try {
      final response = await dio.get('$uri/teamImage/$imageId',
          options: Options(responseType: ResponseType.bytes));
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
    return [];
  }
}
