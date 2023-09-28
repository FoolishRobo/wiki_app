import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:either_dart/either.dart';
import 'package:wiki_app/services/error_service/custom_error.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Either<CustomError, T>> get<T>(String path, Function serializer) async {
    final response = await http.get(Uri.parse('$baseUrl/$path'));

    if (response.statusCode == 200) {
      return Right(serializer(jsonDecode(response.body)) as T);
    } else {
      return Left(CustomError(message: "Something went wrong. Error Code: ${response.statusCode}"));
    }
  }
}
