import 'package:flutter/cupertino.dart';
import 'package:sklepik/models/product.dart';
import 'package:sklepik/services/api.dart';

import '../helpers/screenState.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider() {
    _getProducts();
  }

  ScreenState screenState = ScreenState.Initial;

  List<Product> _products = [];

  String _searchText = '';
  String get searchText => _searchText;
  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  List<Product> products() {
    if (_searchText.isNotEmpty) {
      return _products
          .where((element) =>
              element.title.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
    } else {
      return _products;
    }
  }

  Future<void> _getProducts() async {
    screenState = ScreenState.Loading;
    notifyListeners();

    try {
      final response = await apiGetRequest('products');
      _products = productsFromJson(response.body);
      screenState = ScreenState.Loaded;
    } catch (e) {
      screenState = ScreenState.Error;
    } finally {
      notifyListeners();
    }
  }
}
