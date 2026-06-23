import 'package:coconews/controllers/bookmark_controller.dart';
import 'package:coconews/controllers/connectivity_controller.dart';
import 'package:coconews/controllers/home_controller.dart';
import 'package:coconews/controllers/main_shell_controller.dart';
import 'package:coconews/utils/url_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // for date
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.find<HomeController>();
  final mainShellController = Get.find<MainShellController>();
  final connectivityController = Get.find<ConnectivityController>();
  final bookmarkController = Get.find<BookmarkController>();

  String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}min ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  String currentDate() {
    return DateFormat('EEEE, MMMM d').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => homeController.getNews(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Top Stories Title
                  Text(
                    'Top Stories',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),

                  // Subtitle
                  Text(
                    currentDate(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),

                  // View All Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () => mainShellController.onTap(1),
                        child: Text(
                          'View all',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),

                  Obx(() {

                    if(!connectivityController.isOnline.value){
                      return SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: Center(child: Text('No Internet Connection', style: TextStyle(color: Theme.of(context).colorScheme.onSurface))),
                      );
                    }

                    if(homeController.isLoading.value){
                      return SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if(homeController.isError.isNotEmpty){
                      return SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: Center(child: Text(homeController.isError.value, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))),
                      );
                    }

                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: homeController.articleList.length,
                      itemBuilder: (context, index) {
                        final article = homeController.articleList[index];

                        return Card(
                          color: Theme.of(context).colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.08),
                              width: 1,
                            ),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => UrlHelper.openUrl(article.url),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: article.image,
                                        height: 150,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        memCacheWidth: 800,
                                        placeholder: (context, url) => Container(color: Colors.grey),
                                        errorWidget: (context, url, error) => Container(
                                          color: Colors.grey,
                                          child: const Icon(Icons.broken_image),
                                        ),
                                      )
                                  ),
                                ),
                                SizedBox(height: 10),
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
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      timeAgo(article.publishedAt),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
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
                                )
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
      ),
    );
  }
}
