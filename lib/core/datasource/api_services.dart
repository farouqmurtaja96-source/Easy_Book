import 'package:dio/dio.dart';

class ApiServices {
  final String baseUrl = 'https://gutendex.com/books/?page=2';

  Dio dio = Dio();

  Future getBooks({required String sort}) async {
    Response response = await dio.get('$baseUrl$sort');
    return response.data;
  }
}
