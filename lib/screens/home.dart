import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/model/product_model.dart';
import 'package:online_shop/provider/product_provider.dart';
import 'package:online_shop/screens/product_detail.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void fetchData() async {
    Provider.of<ProductProvider>(context, listen: false).getProducts();
    Provider.of<ProductProvider>(context, listen: false).getCategories();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  String _selectedButton = 'All';
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final products = provider.products;
    final categories = provider.categories;
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
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  //code for Search field
                  _searchField(),
                  SizedBox(height: 40),
                  _bagLady(context),
                  SizedBox(height: 20),

                  SizedBox(
                    height: 40,
                    child: categories == null
                        ? const Center(child: CircularProgressIndicator())
                        : ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              buildSelectableButton("All"),
                              ...categories.map(
                                (category) =>
                                    buildSelectableButton(category.name ?? ""),
                              ),
                            ],
                          ),
                  ),

                  //
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 5,
                            childAspectRatio: 0.6,
                          ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return clothBuild(product, context);
                      },
                    ),
                  ),
                  //
                ],
              ),
            ),
    );
  }

  Container clothBuild(ProductModel product, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: product.images.isEmpty
          ? const Text('No image')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(product: product),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(20),
                    child: Image.network(
                      product.images[0],
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.21,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.21,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Text(
                  product.title ?? 'No title',
                  style: const TextStyle(fontSize: 14),
                ),
                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.price != null ? '\$${product.price}' : 'No price',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border_outlined),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  SizedBox _bagLady(BuildContext context) {
    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none, // Allow image to overflow
        children: [
          // Orange container
          Container(
            padding: EdgeInsets.only(left: 215, top: 20),
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 0.142,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Color.fromRGBO(255, 154, 98, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Big Sale',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Get the trendy \nFashion at a discount \nof up to 50%',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          // Image
          Positioned(
            left: -25,
            top: -20,
            child: Image.asset(
              'images/baggirl.png',
              height:
                  MediaQuery.of(context).size.height *
                  0.18, // 20% of screen height,,
            ),
          ),
        ],
      ),
    );
  }

  _searchField() {
    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  Provider.of<ProductProvider>(
                    context,
                    listen: false,
                  ).searchByTitle(value); 
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  suffixIcon: _isLoading
                      ? Padding(
                          padding: const EdgeInsets.all(12),
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () async {
                            _searchController.clear();
                            setState(() => _isLoading = true);
                            await Provider.of<ProductProvider>(
                              context,
                              listen: false,
                            ).getProducts();
                            setState(() => _isLoading = false);
                          },
                        ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              // Handle filter icon tap
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                CupertinoIcons.slider_horizontal_3,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSelectableButton(String label) {
    bool isSelected = _selectedButton == label;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedButton = label;
          });
          Provider.of<ProductProvider>(
            context,
            listen: false,
          ).filterByCategory(label);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ? Colors.orange : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: isSelected ? 4 : 1,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  //
}
// child: TextField(
//           controller: _searchController,
//           onChanged: (value) {
//             Provider.of<ProductProvider>(context, listen: false)
//                 .searchByTitle(value); // 🔍 Call search
//           },