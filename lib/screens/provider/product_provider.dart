import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:online_shop/screens/Home/model/product_model.dart';
import 'package:online_shop/services/api_services.dart';

class ProductProvider extends ChangeNotifier {
  // ------------------- Products -------------------
  List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];
  List<ProductModel> get products => _filteredProducts;

  // ------------------- Categories -------------------
  List<Category>? _categories;
  List<Category>? get categories => _categories;

  // ------------------- Cart -------------------
  final List<ProductModel> _productCartList = [];
  List<ProductModel> get productCartList => _productCartList;

  final Map<ProductModel, int> _quantities = {};

  int getQuantity(ProductModel product) {
    return _quantities[product] ?? 1;
  }

  double get totalPrice {
    double total = 0.0;
    for (var product in _productCartList) {
      int quantity = _quantities[product] ?? 1;
      int price = product.price ?? 0;
      total += price * quantity;
    }
    return total;
  }

  // ------------------- API: Get Products -------------------
  Future<void> getProducts() async {
    final url = ApiServices.productsUrl;
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      final data = body.map((e) => ProductModel.fromJson(e)).toList();
      _allProducts = data;
      _filteredProducts = data;
      notifyListeners();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // ------------------- API: Get Categories -------------------
  Future<void> getCategories() async {
    final url = ApiServices.categoriesUrl;
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      final data = body.map((e) => Category.fromJson(e)).toList();
      _categories = data;
      notifyListeners();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // ------------------- Filter Products by Category -------------------
  void filterByCategory(String categoryName) {
    if (categoryName == "All") {
      _filteredProducts = _allProducts;
    } else {
      _filteredProducts = _allProducts
          .where((product) => product.category?.name == categoryName)
          .toList();
    }
    notifyListeners();
  }

  // ------------------- Filter Products by Search -------------------
  void searchByTitle(String query) {
    if (query.isEmpty) {
      _filteredProducts = _allProducts;
    } else {
      _filteredProducts = _allProducts
          .where(
            (product) =>
                product.title!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  // ------------------- Cart Management -------------------
  void addToCart(ProductModel product, BuildContext context) {
    _productCartList.add(product);
    _quantities[product] = _quantities[product] ?? 1;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Item added to cart'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
    notifyListeners();
  }

  void removeCart(ProductModel product) {
    _productCartList.remove(product);
    notifyListeners();
  }

  void addQuantity(ProductModel product) {
    if (_quantities.containsKey(product)) {
      _quantities[product] = _quantities[product]! + 1;
      notifyListeners();
    }
  }

  void reduceQuantity(ProductModel product) {
    if (_quantities.containsKey(product) && _quantities[product]! > 1) {
      _quantities[product] = _quantities[product]! - 1;
      notifyListeners();
    }
  }
}