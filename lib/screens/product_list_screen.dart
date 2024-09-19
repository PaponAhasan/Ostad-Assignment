import 'package:ecommerce_admin/screens/product_new_product_screen.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../network/product.dart';
import '../widgets/product_item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  bool _inProgress = false;

  @override
  void initState() {
    fetchProductList();
    super.initState();
  }

  void _removeProduct(Product product) {
    setState(() {
      productList.remove(product); // Remove the product from the list
    });
  }

  Future<void> fetchProductList() async {
    _inProgress = true;
    setState(() {});

    productList = await getProductList(); // Await the future here

    _inProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _inProgress
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    product: productList[index],
                    onDelete: () => _removeProduct(productList[index]),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const ProductNewProductScreen();
              },
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
