import 'package:cached_network_image/cached_network_image.dart';
import 'package:coconews/controllers/bookmark_controller.dart';
import 'package:coconews/controllers/connectivity_controller.dart';
import 'package:coconews/controllers/discover_controller.dart';
import 'package:coconews/utils/url_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverScreen extends StatelessWidget {
  DiscoverScreen({super.key});

  final categoryButtons = ['General', 'World', 'Nation', 'Business', 'Technology', 'Entertainment', 'Sports', 'Science', 'Health'];
  final discoverController = Get.find<DiscoverController>();
  final connectivityController = Get.find<ConnectivityController>();
  final bookmarkController = Get.find<BookmarkController>();

  String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}min ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

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

                // Discover Title
                Text(
                  'Discover',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                // Subtitle
                Text(
                  'News from all around the world',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                SizedBox(height: 10),

                // Category Buttons
                SizedBox(
                  height: 30,
                  child: Obx((){
                    final selected = discoverController.selectedCategory.value;

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryButtons.length,
                      itemBuilder: (context, index){
                        final category = categoryButtons[index];
                        final isSelected = category.toLowerCase() == selected;

                        return GestureDetector(
                          onTap: () => discoverController.getNews(category.toLowerCase()),
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color: isSelected ? Theme.of(context).colorScheme.surfaceVariant : Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurfaceVariant,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),

                SizedBox(height: 15),

                // Body
                Obx(() {

                  if(!connectivityController.isOnline.value){
                    return SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: Center(child: Text('No Internet Connection', style: TextStyle(color: Theme.of(context).colorScheme.onSurface))),
                    );
                  }

                  if(discoverController.isLoading.value){
                    return SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if(discoverController.isError.isNotEmpty){
                    return SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: Center(child: Text(discoverController.isError.value, style: TextStyle(color: Theme.of(context).colorScheme.onSurface))),
                    );
                  }

                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: discoverController.articleList.length,
                    itemBuilder: (context, index){
                      final article = discoverController.articleList[index];

                      return Card(
                        color: Theme.of(context).colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.08),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8, 8, 8, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Texts + Image
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // title
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article.source.name,
                                          style: TextStyle(
                                            fontSize: 16,
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
                                            fontSize: 14,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: 15),

                                  GestureDetector(
                                    onTap: () => UrlHelper.openUrl(article.url),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: article.image,
                                        height: 96,
                                        width: 96,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(color: Colors.grey),
                                        errorWidget: (context, url, error) => Container(
                                          color: Colors.grey,
                                          child: Icon(Icons.broken_image),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 12),

                              // TimeAgo + Bookmark Icon
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    timeAgo(article.publishedAt),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20,
                                    child: PopupMenuButton(
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                      icon: Icon(Icons.more_horiz, color: Theme.of(context).colorScheme.onSurface),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 'save',
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(4, 5, 4, 5),
                                            child: Text('Save', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                                          ),
                                        ),
                                      ],
                                      onSelected: (value){
                                        if(value == 'save'){
                                          bookmarkController.bookmark(article);
                                          bookmarkController.getNews();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),

                            ],
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
