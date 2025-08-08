import 'package:flutter/material.dart';

class CategoryButtons extends StatefulWidget {
  const CategoryButtons({super.key});

  @override
  State <CategoryButtons> createState() => _CategoryButtonsState();
}

class _CategoryButtonsState extends State<CategoryButtons> {
  final List<String> categories = ["All", "Popular", "Recent", "Recommended"];
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: categories.map((category) {
        final isSelected = selectedCategory == category;
        return TextButton(
          onPressed: () {
            setState(() {
              selectedCategory = category;
            });
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 10),
            foregroundColor: isSelected ? Colors.white : Colors.black,
            backgroundColor: isSelected ?  Color.fromRGBO(255, 154, 98, 1) : Colors.grey[200],
          ),
          child: Text(category),
        );
      }).toList(),
    );
  }
}
