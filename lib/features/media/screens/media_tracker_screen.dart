import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pocketvault/features/media/providers/media_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/models/media_item_model.dart';
import '../../../widgets/empty_state_widget.dart';
import '../widgets/add_media_dialog.dart';

class MediaTrackerScreen extends StatefulWidget {
  const MediaTrackerScreen({super.key});

  @override
  State<MediaTrackerScreen> createState() => _MediaTrackerScreenState();
}

class _MediaTrackerScreenState extends State<MediaTrackerScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      //When App Start then load Media Items ,Notify Item error Fix
      Provider.of<MediaProvider>(context, listen: false).loadMediaItems();
    });
  }

  //Helper Function For Show Incon According to MediaType Like book,Movie,
  IconData _getIconForType(MediaType type) {
    switch (type) {
      case MediaType.movie:
        return Icons.movie;
      case MediaType.book:
        return Icons.book;
      case MediaType.series:
        return Icons.tv;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MediaProvider>(
        builder: (context, provider, child) {
          if (provider.mediaItems.isEmpty) {
            return const EmptyStateWidget(
              imagePath: 'assets/images/empty_media.png',
              message: 'Your shopping list is empty.\nTap + to add an item!',
            );
          }
          //List of Media Items
          return AnimationLimiter(
            child: ListView.builder(
              itemCount: provider.mediaItems.length,
              itemBuilder: (_, index) {
                final item = provider.mediaItems[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    _getIconForType(item.type),
                                    color: Theme.of(context).colorScheme.primary,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Chip(
                                          label: Text(
                                            item.status,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                          padding: EdgeInsets.zero,
                                          backgroundColor: Colors.blue.shade50,
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Delete Button
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      provider.deleteMediaItem(item.id!);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              if (item.rating > 0) ...[
                                Row(
                                  children: List.generate(
                                    5,
                                    (starIndex) => Icon(
                                      starIndex < item.rating
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
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
          showAddMediaDialog(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        shape: const  CircleBorder(),

      ),
    );
  }
}
