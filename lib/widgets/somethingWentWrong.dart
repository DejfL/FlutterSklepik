import 'package:flutter/material.dart';
import 'package:sklepik/const.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.info,
            color: primaryColor,
            size: 80,
          ),
          Text(
            'Ooops!\nSomething went wrong',
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
