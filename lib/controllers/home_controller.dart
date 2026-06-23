import 'package:coconews/models/article_model.dart';
import 'package:coconews/services/api_service.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:coconews/utils/constants.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  RxList<ArticleModel> articleList = RxList([]);
  RxList<String> bookmarkIds = RxList([]);
  
  RxBool isLoading = RxBool(false);
  RxString isError = RxString('');
  final articleBox = GetStorage('article');

  @override
  void onReady() {
    super.onReady();
    FlutterNativeSplash.remove();
  }

  @override
  void onInit() {
    super.onInit();
    getNews();
  }

  Future<void> getNews() async {
    
    final cachedAt = articleBox.read<String>('articles_cachedAt');
    final isExpired = cachedAt == null || DateTime.now().difference(DateTime.parse(cachedAt)).inMinutes > 30;
    
    if(articleBox.read('articles') != null && !isExpired){
      final raw = articleBox.read('articles') as List;
      articleList.value = raw.map((article) => ArticleModel.fromJson(Map<String, dynamic>.from(article))).toList();
      debugPrint('home_controller: Cached data reused!');
      return;
    }
    
    isLoading(true);
    isError('');
    
    try {
      final response = await dio.get('/api/v4/top-headlines?category=general&country=us&lang=en&apikey=$kApiKey');
      final data = response.data['articles'] as List;
      articleList.value = data.map((article) => ArticleModel.fromJson(article)).toList();
      articleBox.write('articles', data.map((article) => ArticleModel.fromJson(article).toJson()).toList());
      articleBox.write('articles_cachedAt', DateTime.now().toIso8601String());
      
      debugPrint('home_controller: Fetching news status: ${response.statusCode}');
      debugPrint('home_controller: Everything cached');
      
    } on DioException catch (e) {
    if (e.response?.statusCode == 429) {
    isError('Too many requests, try again later');
    } else if (e.type == DioExceptionType.connectionTimeout ||
    e.type == DioExceptionType.receiveTimeout) {
    isError('Connection timed out, check your internet');
    } else {
    isError('Something went wrong (${e.response?.statusCode ?? 'no response'})');
    }
    debugPrint('Error at getNews: $e');
    } catch (e) {
    isError('Unexpected error');
    debugPrint('Error at getNews: $e');
    } finally {
    isLoading(false);
    }

  }
  
}