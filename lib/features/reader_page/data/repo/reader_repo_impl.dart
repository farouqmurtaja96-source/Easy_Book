import 'package:dartz/dartz.dart';
import 'package:easy_book/core/error/failures.dart';
import 'package:easy_book/features/reader_page/data/repo/reader_repo.dart';
import 'package:http/http.dart' as http;

class ReaderRepoImpl implements ReaderRepo {
  final http.Client client;

  ReaderRepoImpl({required this.client});

  @override
  Future<Either<Failures, String>> getBookText(String bookUrl) async {
    try {
      // التحقق مما إذا كان النص هو رابط URL
      if (bookUrl.startsWith('http')) {
        // إذا كان رابط، قم بتحميل المحتوى
        final response = await client.get(Uri.parse(bookUrl));
        if (response.statusCode == 200) {
          return Right(response.body);
        } else {
          return Left(
            ServerFailure(
              'فشل تحميل محتوى الكتاب. رمز الخطأ: \${response.statusCode}',
            ),
          );
        }
      } else {
        // إذا كان نصاً مباشراً، استخدمه كما هو
        return Right(bookUrl);
      }
    } catch (e) {
      return Left(ServerFailure('حدث خطأ أثناء تحميل الكتاب: $e'));
    }
  }
}
