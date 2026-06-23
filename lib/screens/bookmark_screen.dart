import 'package:cached_network_image/cached_network_image.dart';
import 'package:coconews/controllers/bookmark_controller.dart';
import 'package:coconews/utils/url_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkScreen extends StatelessWidget {
  BookmarkScreen({super.key});

  final bookmarkController = Get.find<BookmarkController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Top Stories Title
                Text(
                  'Bookmark',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                // Subtitle
                Text(
                  'Your saved articles, all in one place',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                SizedBox(height: 10),

                Obx((){
                  if(bookmarkController.articleList.isEmpty){
                    return SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: Center(child: Text('Empty', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))),
                    );
                  }

                  return ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bookmarkController.articleList.length,
                    itemBuilder: (context, index){
                      final article = bookmarkController.articleList[index];

                      return Dismissible(
                        key: Key(article.id),
                        direction: DismissDirection.endToStart,
                        dismissThresholds: {
                          DismissDirection.endToStart: 0.8, // need to swipe 70% to trigger
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          margin: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.delete, color: Theme.of(context).colorScheme.surfaceVariant),
                        ),
                        onDismissed: (direction) {
                          bookmarkController.removeBookmark(article);
                          bookmarkController.getNews();
                        },
                        child: GestureDetector(
                          onTap: () => UrlHelper.openUrl(article.url),
                          child: Card(
                            color: Theme.of(context).colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: Colors.white.withOpacity(0.08),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                        
                                  // Texts + Image
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              article.source.name,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: -0.5,
                                                color: Theme.of(context).colorScheme.onSurface,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              article.title,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Theme.of(context).colorScheme.onSurface,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                        
                                      SizedBox(width: 20),
                        
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: article.image,
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Container(color: Colors.grey),
                                          errorWidget: (context, url, error) => Container(
                                            color: Colors.grey,
                                            child: Icon(Icons.broken_image, color: Theme.of(context).colorScheme.onSurface),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
