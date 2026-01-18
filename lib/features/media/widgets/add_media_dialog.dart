import 'package:flutter/material.dart';
import 'package:pocketvault/data/models/media_item_model.dart';
import 'package:pocketvault/widgets/custo_snk.dart';
import 'package:pocketvault/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import '../../../widgets/CenterCircularProgressIndicator.dart';
import '../providers/media_provider.dart';


Future<void> showAddMediaDialog(BuildContext context) async {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();

  //State for the Dialog
  MediaType selectedMediaType = MediaType.movie;
  String selectedStatus = 'Plan to Watch';
  int currentRating = 0;
  //Loading State
  bool isLoading = false;

  return showDialog(
    context: context,
    barrierDismissible: false,
    // when loading then user tap outside but its not Clased
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Add New Media'),
            content: Form(
              key: formKey,

              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomTextField(
                      controller: titleController,
                      lableText: 'Title',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Item Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    //Media Type DeopDown
                    DropdownButtonFormField<MediaType>(
                      value: selectedMediaType,
                      decoration: const InputDecoration(labelText: 'Type'),
                      items: MediaType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.name.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedMediaType = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),                    // Status Dropdown
                    DropdownButtonFormField<String>(
                      initialValue: selectedStatus,
                      decoration: const InputDecoration(labelText: 'Status'),
                      items:
                          [
                            'Plan to Watch',
                            'Watching',
                            'Completed',
                            'On Hold',
                          ].map((status) {
                            return DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedStatus = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    // Rating Bar star loop
                    const Text('Rating'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            setDialogState(() {
                              currentRating = index + 1;
                            });
                          },
                          icon: Icon(
                            index < currentRating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                          ),
                        );
                      }),
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
                replacement: CenterCircularProgressIndicator(),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      if (formKey.currentState!.validate()) {
                        setDialogState(() {
                          isLoading = true;
                        });
                        final newItem = MediaItem(
                          title: titleController.text.trim(),
                          type: selectedMediaType,
                          status: selectedStatus,
                          rating: currentRating,
                        );
                        //add item to database
                        await Provider.of<MediaProvider>(
                          context,
                          listen: false,
                        ).addMediaItem(newItem);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                          mySnkmsg('Item Added Successfully', context);
                        }

                      }
                    } catch (e) {
                      setDialogState(() {
                        isLoading = false;
                      });
                      mySnkmsg('Error Adding Item', context);
                      debugPrint(e.toString());
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
