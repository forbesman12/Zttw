import 'package:flutter/material.dart';
import 'package:online_shop/model/product_model.dart';
import 'package:online_shop/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  final ProductModel product;

  const ProductPage({super.key, required this.product}); // stored in the class

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.vertical(
                  bottom: Radius.circular(50),
                ),
                child: SizedBox(
                  height: 550,
                  child: Hero(
                    tag: product.id!,
                    child: Image.network(product.images[0], fit: BoxFit.cover),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(27.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.title ?? 'No title',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          product.price != null
                              ? '\$${product.price}'
                              : 'No price',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      product.description ?? 'No description available',
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.6),
                      ),
                    ),
                    SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFF9A62),
                            padding: EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Buy Now',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade800,
                          radius: 35,
                          child: IconButton(
                            onPressed: () {
                              context.read<ProductProvider>().addToCart(
                                product,
                                context,
                              );
                            },
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
