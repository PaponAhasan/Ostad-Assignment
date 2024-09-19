import 'dart:async';

import 'package:ecommerce_admin/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../network/product.dart';
import '../style/style_widget.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  final Product product;

  @override
  State<UpdateProductScreen> createState() =>
      _ProductNewProductScreenState();
}

class _ProductNewProductScreenState extends State<UpdateProductScreen> {
  final productNameController = TextEditingController();
  final unitPriceController = TextEditingController();
  final totalPriceController = TextEditingController();
  final productImageController = TextEditingController();
  final productCodeController = TextEditingController();
  final quantityController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  void initState() {
    productNameController.text = widget.product.productName;
    unitPriceController.text = widget.product.unitPrice;
    totalPriceController.text = widget.product.totalPrice;
    productImageController.text = widget.product.image;
    productCodeController.text = widget.product.productCode;
    quantityController.text = widget.product.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Product',
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

  void _onTabUpdateProductButton() {
    if (_formKey.currentState!.validate()) {
      onUpdateProduct();
    }
  }

  Future<void> onUpdateProduct() async {
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

      Product product = Product(id: widget.product.id, productName: productName, image: image, productCode: productCode, unitPrice: unitPrice, quantity: quantity, totalPrice: totalPrice);
      await updateProduct(product);

      clearTextFields();

      if (currentContext.mounted) {
        ScaffoldMessenger.of(currentContext).showSnackBar(
          const SnackBar(content: Text('Product updated successfully')),
        );

        Navigator.of(currentContext).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ProductListScreen(),
          ),
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
          _inProgress ? const CircularProgressIndicator() : ElevatedButton(
            onPressed: () => _onTabUpdateProductButton(),
            style: appButtonStyle(),
            child: const Text(
              "Update",
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
