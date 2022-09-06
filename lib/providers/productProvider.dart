import 'package:flutter/cupertino.dart';
import 'package:sklepik/models/product.dart';
import 'package:sklepik/services/api.dart';

import '../helpers/screenState.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider() {
    getProducts();
  }

  ScreenState screenState = ScreenState.Initial;

  List<Product> products = [];

  Future<void> getProducts() async {
    screenState = ScreenState.Loading;
    notifyListeners();

    try {
      final response = await apiGetRequest('products');
      products = productsFromJson(response.body);
      screenState = ScreenState.Loaded;
    } catch (e) {
      screenState = ScreenState.Error;
    } finally {
      notifyListeners();
    }
  }
}
