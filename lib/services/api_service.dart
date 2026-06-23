import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(
  baseUrl: 'https://gnews.io',
  connectTimeout: const Duration(seconds: 10),  // time to establish connection
  receiveTimeout: const Duration(seconds: 15),  // time to receive the response
  sendTimeout: const Duration(seconds: 10),     // time to send the request
));