import 'package:flutter/material.dart';
import 'package:online_shop/screens/provider/product_provider.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromARGB(255, 247, 226, 226),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            const Column(
              children: [
                Text(
                  'Category',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 247, 226, 226),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          final categories = productProvider.categories;
          
          if (categories == null) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (categories.isEmpty) {
            return const Center(child: Text('No categories found'));
          }

          return GridView.builder(
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final newCategory = categories[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        newCategory.image ?? '',
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_not_supported);
                        },
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      newCategory.name ?? 'Unnamed Category',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
