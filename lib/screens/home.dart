import 'dart:convert';
import 'package:http/http.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:sklepik/const.dart';
import 'package:sklepik/helpers/screenState.dart';
import 'package:sklepik/models/product.dart';
import 'package:sklepik/providers/cartProvider.dart';
import 'package:sklepik/providers/productProvider.dart';
import 'package:sklepik/services/api.dart';
import 'package:sklepik/widgets/bottomNavigationBar.dart';
import 'package:sklepik/widgets/somethingWentWrong.dart';
import 'package:sklepik/widgets/textFormField.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'Home';
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
      ],
      builder: (context, _) {
        void _searchProduct(String val) {
          Provider.of<ProductProvider>(context, listen: false).searchText = val;
        }

        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    top(context),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      searchEditingController,
                      'Search Product',
                      iconData: Icons.search,
                      onChanged: _searchProduct,
                    ),
                  ],
                ),
              ),
              const Products(),
            ],
          ),
          extendBody: true,
          bottomNavigationBar: const MyBottomNavigationBar(),
        );
      },
    );
  }

  Row top(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Sklepik',
          style: Theme.of(context).textTheme.headline5,
        ),
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: greyColor,
              child: Icon(
                Icons.notifications_none,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Image.asset(
                'assets/images/ja.jpg',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final products = productProvider.products();

    if (productProvider.screenState == ScreenState.Loading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (productProvider.screenState == ScreenState.Error) {
      return const SomethingWentWrong();
    }

    return Expanded(
      child: MasonryGridView.count(
        padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 80),
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final double height = index % 3 == 1 ? 250 : 280;
          return ProductItem(height: height, product: products[index]);
        },
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.height,
    required this.product,
  }) : super(key: key);

  final double height;
  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          _descriptionItem(context),
          _imageItem(context),
          _addToFavorite(),
        ],
      ),
    );
  }

  Positioned _addToFavorite() {
    return Positioned(
      right: 10,
      top: 10,
      child: InkWell(
        onTap: () {},
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            color: primaryColor,
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(
                Icons.favorite_border,
                color: greyColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _imageItem(BuildContext context) {
    return Container(
      height: widget.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: const [
          BoxShadow(
            color: primaryColor,
            blurRadius: 8,
            offset: Offset(0.0, 3),
          )
        ],
        image: DecorationImage(
          image: NetworkImage(
            widget.product.thumbnail,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 10,
            bottom: 10,
            child: InkWell(
              onTap: () => _addToCart(context, widget.product),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Container(
                  color: primaryColor,
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: goldColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart(BuildContext context, Product product) async {
    final Response response =
        await Provider.of<CartProvider>(context, listen: false)
            .addToCart(product);

    if (!mounted) return;

    if (response.statusCode == 200) {
      Flushbar(
        message: 'Added',
        isDismissible: true,
        duration: const Duration(seconds: 2),
      ).show(context);
    } else {
      Flushbar(
        message: 'Error',
        isDismissible: true,
        backgroundColor: Theme.of(context).errorColor,
        duration: const Duration(seconds: 2),
      ).show(context);
    }
  }

  Align _descriptionItem(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: widget.height * 0.25,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: greyColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor,
              blurRadius: 10,
              offset: Offset(0.0, 3),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8,
            top: 20,
            right: 8,
            bottom: 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  widget.product.title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                widget.product.price.toStringAsFixed(2),
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
