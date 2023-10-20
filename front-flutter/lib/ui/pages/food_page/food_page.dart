import 'package:csm_front/core/extensions/context_route_extension.dart';
import 'package:csm_front/data/models/review_model.dart';
import 'package:csm_front/ui/pages/food_page/food_page_cubit.dart';
import 'package:csm_front/ui/pages/food_page/food_page_states.dart';
import 'package:csm_front/ui/widgets/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FoodPageCubit>();
    final foodId = context.getRouteArg<int>();

    cubit.getFood(id: foodId!);

    return MainLayout(body: BlocBuilder<FoodPageCubit, FoodPageState>(
      builder: (context, state) {
        return state.on(
          init: () => const Center(child: CircularProgressIndicator()),
          error: (state) => Center(child: Text(state.error)),
          success: (state) {
            final food = state.food;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300, // Set the desired height
                    child: food.photo != null
                        ? Image.network(food.photo!.url, fit: BoxFit.cover)
                        : const Placeholder(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Por ${food.user?.name ?? 'desconhecido'}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Local: ${food.place?.name ?? 'desconhecido'}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Price: \$${food.price}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Reviews:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        for (final review in food.reviews ?? <ReviewModel>[])
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Avaliado por ${review.user?.nameOrEmail}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Nota: ${review.rating}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Comentário: ${review.comment}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ));
  }
}
