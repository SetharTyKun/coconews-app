import 'package:coconews/models/article_model.dart';
import 'package:coconews/services/api_service.dart';
import 'package:coconews/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DiscoverController extends GetxController {
  RxList<ArticleModel> articleList = RxList([]);
  RxString selectedCategory = RxString('general');
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
    getNews('general');
  }

  // GET news by category
  Future<void> getNews(String category) async {
    selectedCategory(category);
    isError('');

    final cachedAt = articleBox.read<String>('${category}_articles_cachedAt');
    final isExpired = cachedAt == null || DateTime.now().difference(DateTime.parse(cachedAt)).inMinutes > 30;

    if(articleBox.read('${category}_articles') != null && !isExpired){
      final raw = articleBox.read('${category}_articles') as List;
      articleList.value = raw.map((article) => ArticleModel.fromJson(Map<String, dynamic>.from(article))).toList();
      debugPrint('discover_controller: Cached data reused!');
      return;
    }

    isLoading(true);

    try {
      final response = await dio.get('/?category=$category&country=us&lang=en');
      final data = response.data['articles'] as List;
      articleList.value = data.map((article) => ArticleModel.fromJson(article)).toList();

      articleBox.write('${category}_articles', data.map((article) => ArticleModel.fromJson(article).toJson()).toList());
      articleBox.write('${category}_articles_cachedAt', DateTime.now().toIso8601String());

      debugPrint('discover_controller: Fetching $category articles status: ${response.statusCode}');
      debugPrint('discover_controller: Everything cached');

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