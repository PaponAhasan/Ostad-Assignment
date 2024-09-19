import 'package:ecommerce_admin/screens/update_product_screen.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../network/product.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.onDelete,
  });

  final Product product;
  //final Function(Product product) onDelete;
  final VoidCallback onDelete;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  void _removeProduct() {
    deleteOnProduct(widget.product.id ?? '');
  }

  Future<void> deleteOnProduct(String productId) async {
    final currentContext = context;

    setState(() {});

    await deleteProduct(productId);
    widget.onDelete();

    if (currentContext.mounted) {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully')),
      );
      Navigator.of(currentContext).pop();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tileColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
      title: Text(widget.product.productName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${widget.product.productCode}'),
          Text('Price: \$${widget.product.unitPrice}'),
          Text('Quantity: ${widget.product.quantity}'),
          Text('Total Price: \$${widget.product.totalPrice}'),
          const Divider(),
          ButtonBar(
            children: [
              TextButton.icon(
                onPressed: () {
                  // Add your onPressed code here!
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UpdateProductScreen(product: widget.product);
                      },
                    ),
                  );
                },
                label: const Text('Edit'),
                icon: const Icon(Icons.edit),
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.green),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  showAlertDialog(context);
                },
                label: const Text('Delete'),
                icon: const Icon(Icons.delete_outline),
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.red),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                _removeProduct();
              },
            ),
          ],
        );
      },
    );
  }
}
