import 'package:flutter/material.dart';
import 'package:pocketvault/features/shopping/providers/shopping_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/add_item_dialog.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ShoppingProvider>(context, listen: false).loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ShoppingProvider>(
        builder: (context, provider, child) {
          if (provider.shoppingItems.isEmpty) {
            return const Center(
              child: Text(
                'No items in your shopping list.\nAdd one by tapping the + button!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: provider.shoppingItems.length,
            itemBuilder: (_, index) {
              final item = provider.shoppingItems[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                //Checkbox for isBought and toggle Cheakbox value is bool
                child: ListTile(
                  leading: Checkbox(
                    activeColor: Colors.blue,

                    value: item.isBought,
                    onChanged: (bool? value) {
                      provider.toggleBoughtStatus(item);
                    },
                  ),
                  //title
                  title: Text(
                    item.name,
                    style: TextStyle(
                      decoration: item.isBought
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: item.isBought ? Colors.grey : Colors.black,
                    ),
                  ),
                  //Catagory
                  subtitle: Text(item.category),
                  //delete button
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      provider.deleteItem(item.id!);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await showAddItemDialog(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
