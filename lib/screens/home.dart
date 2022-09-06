import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:sklepik/const.dart';
import 'package:sklepik/helpers/screenState.dart';
import 'package:sklepik/providers/productProvider.dart';
import 'package:sklepik/widgets/somethingWentWrong.dart';
import 'package:sklepik/widgets/textFormField.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'Home';
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    top(context),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      searchEditingController,
                      'Search Product',
                      iconData: Icons.search,
                    ),
                  ],
                ),
              ),
              const Products(),
            ],
          ),
        ),
      ),
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
    final products = productProvider.products;

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
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final double height = index % 3 == 1 ? 250 : 300;
          return SizedBox(
            height: height,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: height * 0.3,
                    decoration: const BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    // child: Padding(
                    //   padding: const EdgeInsets.only(top: 20),
                    //   child: Column(children: [
                    //     Text(
                    //       products[index].title,
                    //     ),
                    //   ]),
                    // ),
                  ),
                ),
                Container(
                  height: height * 0.77,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        products[index].image,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
