import 'package:csm_front/models/food_model.dart';
import 'package:csm_front/stores/foods_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

const foodImageUrl =
    'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = FoodsStore();

  @override
  void initState() {
    store.fetchFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSM Front'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ScopedBuilder<FoodsStore, List<FoodModel>>(
        store: store,
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        onError: (context, error) => Text(error),
        onState: (context, foods) => ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, index) {
            final food = foods[index];

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(food.photo?.url ?? ""),
              ),
              title: Text(food.name),
              subtitle: Text("R\$ ${food.price}"),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: foods.length,
        ),
      ),
    );
  }
}
