import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/bookmark_model.dart';
import '../../../widgets/CenterCircularProgressIndicator.dart';
import '../../../widgets/custo_snk.dart';
import '../../../widgets/custom_text_field.dart';
import '../providers/bookmark_provider.dart';

Future<void> showAddBookmarkDialog(BuildContext context) async {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final urlController = TextEditingController();
  final categoryController = TextEditingController();

  // Loading State
  bool isLoading = false;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Add New Bookmark'),
            content: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Title Field
                    CustomTextField(
                      controller: titleController,
                      lableText: 'Title',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // URL Field
                    CustomTextField(
                      controller: urlController,
                      lableText: 'URL',
                      keyboardType: TextInputType.url,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a URL';
                        }
                        if (!Uri
                            .parse(value)
                            .isAbsolute) {
                          return 'Please enter a valid URL';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Category Field
                    CustomTextField(
                      controller: categoryController,
                      lableText: 'Category',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a category';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              Visibility(
                visible: !isLoading,
                replacement: const CenterCircularProgressIndicator(),
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        setDialogState(() {
                          isLoading = true;
                        });

                        final newBookmark = Bookmark(
                          title: titleController.text.trim(),
                          url: urlController.text.trim(),
                          category: categoryController.text.trim(),
                        );

                        // save using Provider
                        await Provider.of<BookmarkProvider>(
                          context,
                          listen: false,
                        ).addBookMarkItem(newBookmark);

                        if (context.mounted) {
                          Navigator.of(context).pop();
                          mySnkmsg('Bookmark Added Successfully', context);
                        }
                      } catch (e) {
                        setDialogState(() {
                          isLoading = false;
                        });
                        if (context.mounted) {
                          mySnkmsg('Error adding bookmark', context);
                        }
                        debugPrint(e.toString());
                      }
                    }
                  },
                  child: const Text('Add'),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}