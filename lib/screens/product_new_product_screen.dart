import 'dart:async';

import 'package:ecommerce_admin/models/product.dart';
import 'package:flutter/material.dart';

import '../network/product.dart';
import '../style/style_widget.dart';

class ProductNewProductScreen extends StatefulWidget {
  const ProductNewProductScreen({super.key});

  @override
  State<ProductNewProductScreen> createState() =>
      _ProductNewProductScreenState();
}

class _ProductNewProductScreenState extends State<ProductNewProductScreen> {
  final productNameController = TextEditingController();
  final unitPriceController = TextEditingController();
  final totalPriceController = TextEditingController();
  final productImageController = TextEditingController();
  final productCodeController = TextEditingController();
  final quantityController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Product',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: buildNewProductForm(),
        ),
      ),
    );
  }

  void _onTabAddProductButton() {
    if (_formKey.currentState!.validate()) {
      addNewProduct();
    }
  }

  Future<void> addNewProduct() async {
    final currentContext = context;

    try {
      _inProgress = true;
      setState(() {});

      String productName = productNameController.text;
      String unitPrice = unitPriceController.text;
      String totalPrice = totalPriceController.text;
      String productCode = productCodeController.text;
      String image = productImageController.text;
      String quantity = quantityController.text;
      String createdAt = DateTime.now().toString();

      Product product = Product(createdAt: createdAt, productName: productName, image: image, productCode: productCode, unitPrice: unitPrice, quantity: quantity, totalPrice: totalPrice);
      await addProduct(product);

      clearTextFields();

      if (currentContext.mounted) {
        ScaffoldMessenger.of(currentContext).showSnackBar(
          const SnackBar(content: Text('Product added successfully')),
        );
      }

    }catch (e) {
      print(e);
    }finally {
      _inProgress = false;
      setState(() {});
    }
  }

  Widget buildNewProductForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: productNameController,
            keyboardType: TextInputType.text,
            decoration: textFieldInputDecoration('Product Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter product name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: unitPriceController,
            keyboardType: TextInputType.number,
            decoration: textFieldInputDecoration('Unit Price'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter unit price';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: totalPriceController,
            keyboardType: TextInputType.number,
            decoration: textFieldInputDecoration('Total Price'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter total price';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: productImageController,
            keyboardType: TextInputType.text,
            decoration: textFieldInputDecoration('Product Image'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter product image';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: productCodeController,
            keyboardType: TextInputType.text,
            decoration: textFieldInputDecoration('Product Code'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter product code';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: textFieldInputDecoration('Quantity'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter quantity';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          _inProgress ? const Center(child: CircularProgressIndicator()) : ElevatedButton(
            onPressed: () => _onTabAddProductButton(),
            style: appButtonStyle(),
            child: const Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  void clearTextFields() {
    productNameController.clear();
    unitPriceController.clear();
    totalPriceController.clear();
    productImageController.clear();
    productCodeController.clear();
    quantityController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    unitPriceController.dispose();
    totalPriceController.dispose();
    productImageController.dispose();
    productCodeController.dispose();
    quantityController.dispose();
  }
}
