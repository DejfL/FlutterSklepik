import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:sklepik/models/product.dart';
import 'package:sklepik/services/api.dart';
import 'package:http/http.dart';

class CartProvider extends ChangeNotifier {
  Future<Response> addToCart(Product product) async {
    final body = json.encode({
      "userId": 1,
      "products": [
        {
          "id": product.id,
          "quantity": 1,
        }
      ]
    });

    return await apiPostRequest('carts/add', body: body);
  }
}
