import 'package:dio/dio.dart';

class ApiServices {
  final String baseUrl = 'https://gutendex.com/books/?';

  Dio dio = Dio();

  Future getBooks({required String sort, String? topic = 'history'}) async {
    Response response = await dio.get('$baseUrl$sort$topic');
    return response.data;
  }

  Future searchBook({required String query}) async {
    print('api${query}');
    Response response = await dio.get('${baseUrl}search=$query');
    return response.data;
  }
}
