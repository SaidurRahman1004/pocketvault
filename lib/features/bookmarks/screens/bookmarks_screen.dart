import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pocketvault/widgets/custo_snk.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../widgets/empty_state_widget.dart';
import '../providers/bookmark_provider.dart';
import '../widgets/add_bookmark_dialog.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<BookmarkProvider>(context, listen: false).loadBookMarkItems();
    });
  }

  //Url Lanchar
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (mounted) {
          mySnkmsg('Could not launch $url', context);
        }
      }
    } catch (e) {
      if (mounted) {
        mySnkmsg('An error occurred while opening the link', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BookmarkProvider>(
        builder: (context, provider, child) {
          if (provider.bookmarkItems.isEmpty) {
            return const EmptyStateWidget(
              imagePath: 'assets/images/empty_bookmarks.png',
              message: 'Your shopping list is empty.\nTap + to add an item!',
            );
          }
          //List
          return AnimationLimiter(
            child: ListView.builder(
              itemCount: provider.bookmarkItems.length,
              itemBuilder: (context, index) {
                final bookmark = provider.bookmarkItems[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0, //slide Cards From Down
                    child: FadeInAnimation(
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.link),
                          title: Text(bookmark.title),
                          subtitle: Text(
                            bookmark.url,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            onPressed: () =>
                                provider.deleteBookMark(bookmark.id!),
                          ),
                          onTap: () => _launchUrl(bookmark.url),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddBookmarkDialog(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
        shape: CircleBorder(),
      ),
    );
  }
}
