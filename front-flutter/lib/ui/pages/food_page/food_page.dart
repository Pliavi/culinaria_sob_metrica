import 'package:csm_front/core/extensions/context_route_extension.dart';
import 'package:flutter/material.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(
        context.getRouteArg<int>().toString(),
      ),
    );
  }
}
