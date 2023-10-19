import 'package:csm_front/data/models/food_model.dart';
import 'package:csm_front/ui/pages/food_page/food_page.dart';
import 'package:flutter/material.dart';

class FoodListTile extends StatelessWidget {
  const FoodListTile({
    super.key,
    required this.food,
  });

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            settings: RouteSettings(arguments: food.id),
            builder: (context) => const FoodPage(),
          ),
        );
      },
      child: ListTile(
        title: Text(food.name),
        subtitle: Text(food.place?.name ?? "No place"),
      ),
    );
  }
}
