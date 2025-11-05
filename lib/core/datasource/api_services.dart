import 'package:dio/dio.dart';

class ApiServices {
  final String baseUrl = 'https://gutendex.com/books/?page=2';

  Dio dio = Dio();

  Future getBooks({required String sort, String? topic = 'history'}) async {
    Response response = await dio.get('$baseUrl$sort$topic');
    return response.data;
  }
}
