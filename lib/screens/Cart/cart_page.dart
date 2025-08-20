import 'package:flutter/material.dart';
import 'package:online_shop/screens/provider/product_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 226, 226),
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
              'Cart',
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.6),
                fontSize: 16,
              ),
            ), // Center text
            Icon(Icons.person), // Last widget (e.g. trailing icon)
          ],
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (BuildContext context, cartList, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartList.productCartList.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartList.productCartList[index];
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                cartItem.images[0],
                                height: 120,
                                width: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(cartItem.title.toString()),
                                            Text(
                                              cartItem.description.toString(),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          cartList.removeCart(cartItem);
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '\$${(cartItem.price! * cartList.getQuantity(cartItem)).toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.remove_circle_outline,
                                            ),
                                            onPressed: () {
                                              cartList.reduceQuantity(cartItem);
                                            },
                                          ),
                                          Text(
                                            cartList
                                                .getQuantity(cartItem)
                                                .toString(),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                            ),
                                            onPressed: () {
                                              cartList.addQuantity(cartItem);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total:',  style: TextStyle(fontSize: 19)),
                        Text(
                          '\$${cartList.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                
                    /// Checkout button
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
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
