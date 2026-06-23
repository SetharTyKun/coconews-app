import 'package:coconews/models/article_model.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class BookmarkController extends GetxController {
  RxList<ArticleModel> articleList = RxList([]);
  final bookmarkBox = GetStorage('bookmark');

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

  void getNews(){
    final raw = (bookmarkBox.read('bookmark') ?? []) as List;
    articleList.value = raw.map((article) => ArticleModel.fromJson(article)).toList();
    debugPrint('bookmark_controller: Load bookmarked article from cache');
  }

  void bookmark(ArticleModel article){
    final List current = bookmarkBox.read('bookmark') ?? [];

    bool isFound = current.any((a) => a['id'] == article.toJson()['id']);
    if(isFound){
      return;
    }

    current.add(article.toJson());
    bookmarkBox.write('bookmark', current);
    debugPrint('bookmark_controller: ${article.source.name} saved!');
  }

  void removeBookmark(ArticleModel article){
    final List current = bookmarkBox.read('bookmark') ?? [];
    current.removeWhere((item) => item['id'] == article.id);

    bookmarkBox.write('bookmark', current);
    debugPrint('bookmark_controller: ${article.source.name} removed!');
  }

  bool isBookmarked(String id){
    return articleList.any((article) => article.id == id);
  }

}