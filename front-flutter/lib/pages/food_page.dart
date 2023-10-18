import 'package:csm_front/models/food_model.dart';
import 'package:csm_front/services/food_service/food_service.dart';
import 'package:csm_front/stores/states/food_store.dart';
import 'package:csm_front/widgets/fetch_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({
    Key? key,
    this.foodId,
  }) : super(key: key);

  final int? foodId;

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final store = FoodStore();

  @override
  void initState() {
    store.getFood(
      id: widget.foodId!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CSM Front',
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: FetchBuilder(
        fetcher: FoodService().getFood(id: widget.foodId!),
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
        ),
        onError: (context, error) => Center(
          child: Text(
            error,
            style: const TextStyle(
              color: Colors.red, // Set error text color to red
              fontSize: 16,
            ),
          ),
        ),
        onState: (context, food) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0), // Add padding to the content
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food!.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.place,
                              size: 16,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              food.place?.name ?? 'Sem local',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              clipBehavior: Clip.antiAlias,
                              child: Image.network(
                                food.photo?.url ?? "",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              clipBehavior: Clip.antiAlias,
                              child: Image.network(
                                food.photo?.url ?? "",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              clipBehavior: Clip.antiAlias,
                              child: Image.network(
                                food.photo?.url ?? "",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final review = food.reviews?[index];

                        return ListTile(
                          leading: CircleAvatar(
                              child: Text(
                            review?.user?.email[0] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          title: Text(
                            review?.user?.email ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            review?.comment ?? '',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: food.reviews?.length ?? 0,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    )
  }
}
