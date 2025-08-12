import 'package:flutter/material.dart';
import 'package:online_shop/provider/product_provider.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final categories = context.watch<ProductProvider>().categories;
    print('List of categoris: $categories');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 226, 226),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Image.asset('images/Vector.png', height: 24),
                onPressed: () {
                  // Handle tap
                },
              ),
            ),
            Text(
              'Hello Zarkie \n Jarkata, IND',
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.6),
                fontSize: 16,
              ),
            ), // Center text
            Icon(Icons.person), // Last widget (e.g. trailing icon)
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 247, 226, 226),

      body: Consumer<ProductProvider>(
        builder: (context, categories, child) {
          return GestureDetector(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriesDetails()));
            },
            child: GridView.builder(
              itemCount: categories.categories!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,

                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final newCateries = categories.categories![index];
                return categories.categories == null
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(30),
                              child: Image.network(
                                newCateries.image.toString(),
                                errorBuilder: (context, error, stackTrace) {
                                  return Text('Problem Loading Image');
                                },
                              ),
                            ),
                            Text(newCateries.name.toString()),
                          ],
                        ),
                      );
              },
            ),
          );
        },
      ),
    );
  }
}
