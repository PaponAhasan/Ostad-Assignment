import 'dart:convert';

import 'package:ecommerce_admin/models/product.dart';
import 'package:ecommerce_admin/utils/util.dart';
import 'package:http/http.dart';

Future<List<Product>> getProductList() async {
  List<Product> productList = [];

  try {
    Uri uri = Uri.parse("$BASE_URL/api/v1/ReadProduct");
    Response response = await get(uri);
    if (response.statusCode == 200) {
      String responseBody = response.body;
      if (responseBody.isNotEmpty) {
        Map<String, dynamic> productResponse = jsonDecode(responseBody);
        if (productResponse['status'] == "success") {
          var responseData = productResponse['data'];
          print(responseData);
          for (var item in responseData) {
            Product product = Product.fromJson(item);
            // Product product = Product(
            //   id: item['_id'] ?? '',
            //   productName: item['ProductName'] ?? '',
            //   unitPrice: item['UnitPrice'] ?? '',
            //   totalPrice: item['TotalPrice'] ?? '',
            //   quantity: item['Qty'] ?? '',
            //   productCode: item['ProductCode'] ?? '',
            //   image: item['Img'] ?? '',
            //   createdAt: item['CreatedDate'] ?? '',
            // );
            productList.add(product);
          }
          print(productList);
        } else {
          print(productResponse['message']);
        }
      } else {
        print("Empty Response");
      }
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e);
  }

  return productList.reversed.toList();
}

Future<void> addProduct(Product product) async {
  try {
    Uri uri = Uri.parse("$BASE_URL/api/v1/CreateProduct");
    Response response = await post(uri,
        headers: getHeaders(), body: jsonEncode(product.toJson()));
    print(response.body);
    if (response.statusCode == 200) {
      String responseBody = response.body;
      if (responseBody.isNotEmpty) {
        Map<String, dynamic> productResponse = jsonDecode(responseBody);
        if (productResponse['status'] == "success") {
          print(productResponse['data']);
        } else {
          print(productResponse['data']);
        }
      } else {
        print("Empty Response");
      }
    } else {
      print("statusCode: ${response.statusCode}");
    }
  } catch (e) {
    print(e);
  }
}

Future<void> updateProduct(Product product) async {
  try {
    Uri uri =
        Uri.parse("$BASE_URL/api/v1/UpdateProduct/${product.id}");
    Response response = await post(uri,
        headers: getHeaders(), body: jsonEncode(product.toJson()));
    print(response.body);
    if (response.statusCode == 200) {
      String responseBody = response.body;
      if (responseBody.isNotEmpty) {
        Map<String, dynamic> productResponse = jsonDecode(responseBody);
        if (productResponse['status'] == "success") {
          print(productResponse['data']);
        } else {
          print(productResponse['data']);
        }
      } else {
        print("Empty Response");
      }
    } else {
      print("statusCode: ${response.statusCode}");
    }
  } catch (e) {
    print(e);
  }
}

Future<void> deleteProduct(String? productId) async {
  try {
    Uri uri = Uri.parse("$BASE_URL/api/v1/DeleteProduct/$productId");
    Response response = await get(uri, headers: getHeaders());
    print(response.body);
    if (response.statusCode == 200) {
      String responseBody = response.body;
      if (responseBody.isNotEmpty) {
        Map<String, dynamic> productResponse = jsonDecode(responseBody);
        if (productResponse['status'] == "success") {
          print(productResponse['data']);
        } else {
          print(productResponse['data']);
        }
      } else {
        print("Empty Response");
      }
    } else {
      print("statusCode: ${response.statusCode}");
    }
  } catch (e) {
    print(e);
  }
}
