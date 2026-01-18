import 'package:flutter/material.dart';
import 'package:pocketvault/data/models/shopping_item_model.dart';
import 'package:pocketvault/widgets/custo_snk.dart';
import 'package:pocketvault/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../../widgets/CenterCircularProgressIndicator.dart';
import '../providers/shopping_provider.dart';

Future<void> showAddItemDialog(BuildContext context) async{
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  bool isLoading = false;
  return showDialog(
    context: context,
    barrierDismissible: false,
    // when loading then user tap outside but its not Clased
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Add New Item'),
            content: Form(
              key: formKey,

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomTextField(
                    controller: nameController,
                    lableText: 'Item Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Item Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: categoryController,
                    lableText: 'Category (e.g., Groceries)',
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
                        final newItem = ShoppingItem(
                          name: nameController.text.trim(),
                          category: categoryController.text.trim(),
                          isBought: false,
                        );
                        //add item to database
                        await Provider.of<ShoppingProvider>(
                          context,
                          listen: false,
                        ).addItem(newItem);
                        Navigator.of(context).pop();
                        mySnkmsg('Item Added Successfull', context);
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
